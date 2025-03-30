import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qlct/presentation/cubit/auth/auth_cubit.dart';
import 'package:qlct/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:qlct/domain/usecases/get_transactions_usecase.dart';
import 'package:qlct/domain/usecases/update_transaction_usecase.dart';
import 'package:qlct/data/repositories/transaction_repository.dart';
import 'package:qlct/data/repositories/auth_repository.dart';
import 'package:qlct/domain/usecases/auth_usecase.dart';
import 'package:qlct/presentation/screens/login/login_screen.dart';

import 'domain/usecases/add_transactions_usecase.dart';
import 'domain/usecases/delete_transactions_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final transactionRepository = TransactionRepository();

  runApp(MyApp(transactionRepository: transactionRepository));
}

class MyApp extends StatelessWidget {
  final TransactionRepository transactionRepository;

  const MyApp({Key? key, required this.transactionRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthUseCase(AuthRepository())),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(
            getTransactionsUseCase: GetTransactionsUseCase(transactionRepository),
            addTransactionUseCase: AddTransactionUseCase(transactionRepository),
            updateTransactionUseCase: UpdateTransactionUseCase(transactionRepository),
            deleteTransactionUseCase: DeleteTransactionUseCase(transactionRepository),
            transactionRepository: transactionRepository,
          )..fetchTransactions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
