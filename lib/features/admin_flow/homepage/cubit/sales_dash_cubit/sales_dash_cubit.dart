// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
//
// part 'sales_dash_state.dart';
//
// class SalesDashCubit extends Cubit<SalesDashState> {
//   SalesDashCubit() : super(SalesDashInitial());
//
//   Future<void> getTotalIncome() async {
//     emit(SalesDashLoading());
//     try {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('Cinemas')
//           .doc("Plaza Cinema")
//           .get();
//
//       List<dynamic> tickets = doc.get('tickets');
//
//       int total = 0;
//       int totalCustomers = 0;
//
//       for (var ticket in tickets) {
//         if (ticket is Map && ticket.containsKey('totalPrice')) {
//           var price = ticket['totalPrice'];
//           if (price is int) {
//             total += price;
//           } else if (price is double) {
//             total += price.toInt();
//           }
//         }
//       }
//
//       emit(SalesDashSuccess(total));
//     } catch (e) {
//       emit(SalesDashError('Something went wrong :$e'));
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sales_dash_state.dart';


class SalesDashCubit extends Cubit<SalesDashState> {
  SalesDashCubit() : super(SalesDashInitial());

  int? totalIncome;
  int? totalCustomers;
  int? totalMovies;
  Future<void> getTotalIncome() async {
    if (totalIncome != null && totalCustomers != null) {
      emit(SalesDashSuccess(totalIncome: totalIncome??0,
        totalCustomers: totalCustomers??0,
      ));
      return;
    }

    emit(SalesDashLoading());

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc("Point 90 Cinema")
          .get();

      List<dynamic> tickets = doc.get('tickets');
      int total = 0;

      for (var ticket in tickets) {
        if (ticket is Map && ticket.containsKey('totalPrice')) {
          var price = ticket['totalPrice'];
          if (price is int) {
            total += price;
          } else if (price is double) {
            total += price.toInt();
          }
        }
      }

      int ticketCount = tickets.length;

      totalIncome = total;
      totalCustomers = ticketCount;

      emit(SalesDashSuccess(
        totalIncome: totalIncome??0,
        totalCustomers:totalCustomers??0,
      totalMovies: totalMovies));
    } catch (e) {
      emit(SalesDashError('Something went wrong : $e'));
    }
  }

  Future<void> getTotalMovies() async {
    emit(SalesDashLoading());

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc("Point 90 Cinema")
          .get();

      List<dynamic> movies = doc.get('movies');
      totalMovies = 0;

      totalMovies = movies.length;

      emit(SalesDashSuccess(
        totalIncome: totalIncome,
       totalCustomers: totalCustomers,
       totalMovies: totalMovies
      ));
    } catch (e) {
      emit(SalesDashError('Something went wrong :$e'));
    }
  }

}
