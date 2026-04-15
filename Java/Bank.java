import java.util.*;

class Bank {

    private HashMap<Integer, Account> accounts = new HashMap<>();

    public void createaccount(Scanner sc) {
        System.out.print("Enter Account Number: ");
        int accNo = sc.nextInt();
        sc.nextLine();
        if (accounts.containsKey(accNo)) {
            System.out.println("Account already exists");
            return;
        }
        System.out.print("Enter Account Holder Name: ");
        String name = sc.nextLine();

        System.out.print("Enter Account Type (Savings/Current): ");
        String type = sc.nextLine();

        System.out.print("Enter Initial Balance: ");
        double balance = sc.nextDouble();

        sc.nextLine();

        System.out.print("Set Password: ");
        String password = sc.nextLine();
        Account acc = new Account(name, accNo, type,
                balance, password);
        accounts.put(accNo, acc);
        System.out.println("Account created successfully");
    }


    private Account login(Scanner sc) {

        System.out.print("Enter Account Number: ");
        int accNo = sc.nextInt();
        sc.nextLine();
        Account acc = accounts.get(accNo);
        if (acc == null) {
            System.out.println("Account not found");
            return null;
        }
        System.out.print("Enter your Password: ");
        String pass = sc.nextLine();
        if (!acc.authenticate(pass)) {
            System.out.println("Invalid password entered,try again to login");
            return null;
        }
        return acc;
    }

    public void depositmoney(Scanner sc) {
        Account acc = login(sc);
        if (acc == null)
            return;
        System.out.print("Enter amount: ");
        double amount = sc.nextDouble();
        acc.deposit(amount);
    }

    public void withdrawmoney(Scanner sc) {
        Account acc = login(sc);
        if (acc == null)
            return;
        System.out.print("Enter amount: ");
        double amount = sc.nextDouble();
        acc.withdraw(amount);
    }

    public void transfermoney(Scanner sc) {
        System.out.print("Sender Account Login\n");
        Account sender = login(sc);
        if (sender == null)
            return;
        System.out.print("Enter Receiver Account Number: ");
        int receiverNo = sc.nextInt();
        Account receiver = accounts.get(receiverNo);
        if (receiver == null) {
            System.out.println("Receiver account not found");
            return;
        }
        System.out.print("Enter amount: ");
        double amount = sc.nextDouble();
        sender.transfer(receiver, amount);
    }

    public void checkbalance(Scanner sc) {
        Account acc = login(sc);
        if (acc != null)
            acc.showBalance();
    }

    public void transactionhistory(Scanner sc) {
        Account acc = login(sc);
        if (acc != null)
            acc.showTransactions();
    }
}