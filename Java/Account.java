import java.util.*;

class Account {
    private String accountHolder;
    private int accountNumber;
    private String accountType;
    private double balance;
    private String password;
    private ArrayList<String> transactions = new ArrayList<>();

    public Account(String accountHolder, int accountNumber,
                   String accountType, double balance,
                   String password) {
        this.accountHolder = accountHolder;
        this.accountNumber = accountNumber;
        this.accountType = accountType;
        this.balance = balance;
        this.password = password;

        transactions.add("Account created with balance: " + balance);
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public boolean authenticate(String pass) {
        return password.equals(pass);
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            System.out.println("Invalid amount");
            return;
        }
        balance += amount;
        transactions.add("Deposited: " + amount);

        System.out.println("Deposit successful");
    }

    public void withdraw(double amount) {
        if (amount <= 0) {
            System.out.println("Invalid amount");
            return;
        }
        if (amount > balance) {
            System.out.println("Insufficient balance");
            return;
        }
        balance -= amount;
        transactions.add("Withdrawn: " + amount);
        System.out.println("Withdrawal successful");
    }

    public void transfer(Account receiver, double amount) {
        if (amount > balance) {
            System.out.println("Insufficient balance");
            return;
        }

        this.balance -= amount;
        receiver.balance += amount;

        transactions.add("Transferred " + amount + " to Account: " + receiver.accountNumber);

        receiver.transactions.add("Received " + amount + " from Account: " + this.accountNumber);

        System.out.println("Transfer successful");
    }

    public void showBalance() {

        System.out.println("Current Balance: " + balance);
    }

    public void showTransactions() {

        System.out.println("Transaction History:");

        for (String t : transactions) {
            System.out.println(t);
        }
    }
}