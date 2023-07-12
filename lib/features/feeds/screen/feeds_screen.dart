import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_feed/core/const.dart';
import 'package:perfect_feed/core/injection_container.dart';
import 'package:perfect_feed/data/model/feed.dart';
import 'package:perfect_feed/features/feeds/bloc/feeds_bloc.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key, required this.title});

  final String title;

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  late FeedsBloc bloc;
  final scroolControler = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = FeedsBloc(getIt(), getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is LoadedFeedsState) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Slider(
                      label: '${state.radius}',
                      value: state.radius,
                      divisions: maxRadiusInKm.toInt(),
                      min: 0,
                      max: maxRadiusInKm,
                      onChanged: (newValue) => bloc.add(SetUserFeedRadiusEvent(newValue)),
                    ),
                    const SizedBox(height: 4),
                    Text('Radius: ${state.radius.toInt()} km', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () => bloc.add(ResetEvent()), child: Text('Reset')),
                    const Divider(),
                    Flexible(
                      child: ListView.separated(
                        controller: scroolControler,
                        itemCount: state.feeds.length,
                        itemBuilder: (ctx, index) {
                          if (index == state.feeds.length - 1) {
                            bloc.add(GetMoreFeedsEvent());
                          }
                          return FeedItem(feed: state.feeds[index]);
                        },
                        separatorBuilder: (_, __) => const Divider(),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('No feeds');
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class FeedItem extends StatelessWidget {
  final Feed feed;

  const FeedItem({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<FeedsBloc>().add(AddFavoriteActivityEvent(feed.activityType));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You have added ${feed.activityType.name} as you favorite activity"),
          ),
        );
      },
      child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(feed.title), const SizedBox(height: 10), Text(feed.activityType.name)],
          )),
    );
  }
}
