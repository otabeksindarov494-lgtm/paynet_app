import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Contact {
  const Contact({required this.name, required this.phone});

  final String name;
  final String phone;
}

class ContactsState {
  const ContactsState({
    required this.allContacts,
    required this.filteredContacts,
    this.searchQuery = '',
  });

  final List<Contact> allContacts;
  final List<Contact> filteredContacts;
  final String searchQuery;

  ContactsState copyWith({
    List<Contact>? allContacts,
    List<Contact>? filteredContacts,
    String? searchQuery,
  }) {
    return ContactsState(
      allContacts: allContacts ?? this.allContacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  factory ContactsState.initial() => const ContactsState(
    allContacts: [],
    filteredContacts: [],
  );
}

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsState.initial());

  void loadContacts() {
    final contacts = [
      const Contact(name: 'Sindarov Otabek', phone: '+998 50 054 47 64'),
      const Contact(name: 'Xolmatov Alisher', phone: '+998 50 054 47 64'),
      const Contact(name: 'Sindarova Gozal', phone: '+998 50 054 47 64'),
      const Contact(name: 'Ismoilov Abror', phone: '+998 50 054 47 64'),
      const Contact(name: 'Polatov Oyatulloh', phone: '+998 50 054 47 64'),
      const Contact(name: 'Norchayeva Mamura', phone: '+998 50 054 47 64'),
    ];

    emit(state.copyWith(
      allContacts: contacts,
      filteredContacts: contacts,
    ));
  }

  void search(String query) {
    final lowerQuery = query.toLowerCase();

    final filtered = state.allContacts.where((contact) {
      return contact.name.toLowerCase().contains(lowerQuery) ||
          contact.phone.contains(query);
    }).toList();

    emit(state.copyWith(
      filteredContacts: filtered,
      searchQuery: query,
    ));
  }
}

class ContactsSheet extends StatelessWidget {
  const ContactsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit()..loadContacts(),
      child: const _ContactsSheetBody(),
    );
  }
}

class _ContactsSheetBody extends StatelessWidget {
  const _ContactsSheetBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Контакты',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Имя или номер телефона',
            hintStyle: TextStyle(color: Colors.white54),
            icon: Icon(Icons.search, color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            context.read<ContactsCubit>().search(value);
          },
        ),

        Expanded(
          child: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state.filteredContacts.isEmpty) {
                return const Center(
                  child: Text(
                    'Контакт топилмади',
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = state.filteredContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white12,
                      child: Text(
                        contact.name[0],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      contact.phone,
                      style: const TextStyle(color: Colors.white54),
                    ),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (_) => RequestMoneyPage(
                      //     name: contact.name,
                      //     phone: contact.phone,
                      //   ),
                      // ));
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}