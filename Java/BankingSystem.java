//A console based banking system

import java.util.*;

public class BankingSystem {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Bank bank = new Bank();
        int choice;

        do {
            System.out.println("\n      Banking System Menu     ");
            System.out.println("1 Create Account");
            System.out.println("2 Deposit");
            System.out.println("3 Withdraw");
            System.out.println("4 Transfer");
            System.out.println("5 Check Balance");
            System.out.println("6 Transaction History");
            System.out.println("7 Exit");

            System.out.print("Enter your choice: ");
            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    bank.createaccount(sc);
                    break;

                case 2:
                    bank.depositmoney(sc);
                    break;

                case 3:
                    bank.withdrawmoney(sc);
                    break;

                case 4:
                    bank.transfermoney(sc);
                    break;

                case 5:
                    bank.checkbalance(sc);
                    break;

                case 6:
                    bank.transactionhistory(sc);
                    break;

                case 7:
                    System.out.println("Thank you for using our Banking System");
                    break;

                default:
                    System.out.println("Invalid choice");
            }

        } while (choice != 7);
        sc.close();
    }
}