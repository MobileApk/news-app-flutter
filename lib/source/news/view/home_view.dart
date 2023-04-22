import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/source/authentication/cubit/login_cubit.dart';
import 'package:news_app_flutter/source/news/cubit/news_cubit.dart';
import 'package:news_app_flutter/source/news/view/detail_news_view.dart';
import 'package:news_app_flutter/source/utils/app_helper.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var newsCubit = context.read<NewsCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home View"),
          actions: [
            IconButton(
              tooltip: "Logout",
              onPressed: () {
                context.read<LoginCubit>().logoutUser(context);
              },
              icon: Row(
                children: const [
                  Icon(
                    Icons.logout,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              titleSearchBar(context, newsCubit),
              const SizedBox(
                height: 15,
              ),
              categoryDropDown(newsCubit),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state.status != Status.loaded) {
                    return const CircularProgressIndicator();
                  } else {
                    return newsListItem(state);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded newsListItem(NewsState state) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.listOfNewsData?.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return DetailNewsView(
                      newsData: state.listOfNewsData![index],
                    );
                  }),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      state.listOfNewsData?[index].title ?? "",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            state.listOfNewsData?[index].content ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            state.listOfNewsData![index].imageUrl!,
                            fit: BoxFit.fill,
                            height: 70,
                            width: 100,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding categoryDropDown(NewsCubit newsCubit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: Colors.black),
        ),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return DropdownButton(
              isExpanded: true,
              value: state.dropdownValue ?? "all",
              icon: const Icon(Icons.keyboard_arrow_down),
              dropdownColor: Colors.red[200],
              items:
                  ["all", "science", "business", "sports"].map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(items),
                  ),
                );
              }).toList(),
              onChanged: newsCubit.categoryChange,
            );
          },
        ),
      ),
    );
  }

  Padding titleSearchBar(BuildContext context, NewsCubit newsCubit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: Colors.black),
        ),
        child: ListTile(
          trailing: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              newsCubit.searchItemFromList();
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
          ),
          title: TextField(
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              newsCubit.searchItemFromList();
            },
            onChanged: context.read<NewsCubit>().titleSearch,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search By Title',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
