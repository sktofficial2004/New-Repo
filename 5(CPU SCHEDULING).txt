import java.util.*;

public class CPUSceduling {

    static Scanner sc = new Scanner(System.in);

    // ================= FCFS ==================
    static void fcfs() {
        System.out.print("Enter number of processes: ");
        int n = sc.nextInt();
        int pid[] = new int[n], at[] = new int[n], bt[] = new int[n];
        int ct[] = new int[n], tat[] = new int[n], wt[] = new int[n];
        
        for (int i = 0; i < n; i++) {
            System.out.print("Enter Arrival Time of P" + (i+1) + ": ");
            at[i] = sc.nextInt();
            System.out.print("Enter Burst Time of P" + (i+1) + ": ");
            bt[i] = sc.nextInt();
            pid[i] = i+1;
        }

        // Sort by arrival time
        for (int i=0; i<n-1; i++)
            for (int j=0; j<n-i-1; j++)
                if (at[j] > at[j+1]) {
                    int tmp = at[j]; at[j]=at[j+1]; at[j+1]=tmp;
                    tmp = bt[j]; bt[j]=bt[j+1]; bt[j+1]=tmp;
                    tmp = pid[j]; pid[j]=pid[j+1]; pid[j+1]=tmp;
                }

        ct[0] = at[0] + bt[0];
        for (int i=1; i<n; i++)
            ct[i] = (at[i] > ct[i-1]) ? at[i] + bt[i] : ct[i-1] + bt[i];

        double avgTAT=0, avgWT=0;
        System.out.println("
PID	AT	BT	CT	TAT	WT");
        for (int i=0;i<n;i++){
            tat[i]=ct[i]-at[i];
            wt[i]=tat[i]-bt[i];
            avgTAT+=tat[i];
            avgWT+=wt[i];
            System.out.println(pid[i]+"	"+at[i]+"	"+bt[i]+"	"+ct[i]+"	"+tat[i]+"	"+wt[i]);
        }
        System.out.println("Average TAT="+(avgTAT/n)+" Average WT="+(avgWT/n));
    }

    // ================= SJF (Preemptive) ==================
    static void sjfPreemptive() {
        System.out.print("Enter number of processes: ");
        int n = sc.nextInt();
        int pid[] = new int[n], at[] = new int[n], bt[] = new int[n],
            rt[] = new int[n], ct[] = new int[n];
        for (int i=0;i<n;i++){
            System.out.print("Enter Arrival Time of P"+(i+1)+": ");
            at[i]=sc.nextInt();
            System.out.print("Enter Burst Time of P"+(i+1)+": ");
            bt[i]=sc.nextInt();
            rt[i]=bt[i]; pid[i]=i+1;
        }
        int complete=0, t=0, minm=Integer.MAX_VALUE, shortest=0; boolean check=false;
        while (complete!=n){
            for(int j=0;j<n;j++){
                if(at[j]<=t && rt[j]<minm && rt[j]>0){
                    minm=rt[j]; shortest=j; check=true;
                }
            }
            if(!check){ t++; continue; }
            rt[shortest]--; minm=(rt[shortest]==0)?Integer.MAX_VALUE:rt[shortest];
            if(rt[shortest]==0){ complete++; ct[shortest]=t+1; }
            t++; check=false;
        }
        int tat[]=new int[n], wt[]=new int[n]; double avgTAT=0,avgWT=0;
        System.out.println("
PID	AT	BT	CT	TAT	WT");
        for(int i=0;i<n;i++){
            tat[i]=ct[i]-at[i]; wt[i]=tat[i]-bt[i];
            avgTAT+=tat[i]; avgWT+=wt[i];
            System.out.println(pid[i]+"	"+at[i]+"	"+bt[i]+"	"+ct[i]+"	"+tat[i]+"	"+wt[i]);
        }
        System.out.println("Average TAT="+(avgTAT/n)+" Average WT="+(avgWT/n));
    }

    // ================= Priority (Non-Preemptive) ==================
    static void priority() {
        System.out.print("Enter number of processes: ");
        int n = sc.nextInt();
        int pid[]=new int[n], at[]=new int[n], bt[]=new int[n], pr[]=new int[n];
        int ct[]=new int[n], tat[]=new int[n], wt[]=new int[n];
        for(int i=0;i<n;i++){
            System.out.print("Enter Arrival Time of P"+(i+1)+": ");
            at[i]=sc.nextInt();
            System.out.print("Enter Burst Time of P"+(i+1)+": ");
            bt[i]=sc.nextInt();
            System.out.print("Enter Priority (Lower=Higher): ");
            pr[i]=sc.nextInt();
            pid[i]=i+1;
        }

        boolean completed[]=new boolean[n]; int t=0, complete=0;
        while(complete<n){
            int idx=-1, minPr=Integer.MAX_VALUE;
            for(int i=0;i<n;i++){
                if(at[i]<=t && !completed[i]){
                    if(pr[i]<minPr){ minPr=pr[i]; idx=i; }
                    else if(pr[i]==minPr && at[i]<at[idx]) idx=i;
                }
            }
            if(idx==-1){ t++; continue; }
            t+=bt[idx]; ct[idx]=t; completed[idx]=true; complete++;
        }

        double avgTAT=0, avgWT=0;
        System.out.println("
PID	AT	BT	PR	CT	TAT	WT");
        for(int i=0;i<n;i++){
            tat[i]=ct[i]-at[i]; wt[i]=tat[i]-bt[i];
            avgTAT+=tat[i]; avgWT+=wt[i];
            System.out.println(pid[i]+"	"+at[i]+"	"+bt[i]+"	"+pr[i]+"	"+ct[i]+"	"+tat[i]+"	"+wt[i]);
        }
        System.out.println("Average TAT="+(avgTAT/n)+" Average WT="+(avgWT/n));
    }

    // ================= Round Robin ==================
    static void roundRobin() {
        System.out.print("Enter number of processes: ");
        int n = sc.nextInt();
        int pid[]=new int[n], bt[]=new int[n], rt[]=new int[n], at[]=new int[n], ct[]=new int[n];
        for(int i=0;i<n;i++){
            System.out.print("Enter Arrival Time of P"+(i+1)+": ");
            at[i]=sc.nextInt();
            System.out.print("Enter Burst Time of P"+(i+1)+": ");
            bt[i]=sc.nextInt();
            rt[i]=bt[i]; pid[i]=i+1;
        }
        System.out.print("Enter Time Quantum: ");
        int tq=sc.nextInt();

        Queue<Integer> q=new LinkedList<>();
        int t=0; boolean[] inQ=new boolean[n]; int complete=0;
        while(complete<n){
            for(int i=0;i<n;i++)
                if(at[i]<=t && rt[i]>0 && !inQ[i]){ q.add(i); inQ[i]=true; }
            if(q.isEmpty()){ t++; continue; }
            int idx=q.poll();
            int exec=Math.min(tq, rt[idx]);
            rt[idx]-=exec; t+=exec;
            for(int i=0;i<n;i++)
                if(at[i]<=t && rt[i]>0 && !inQ[i]){ q.add(i); inQ[i]=true; }
            if(rt[idx]>0) q.add(idx);
            else { ct[idx]=t; complete++; }
        }

        int tat[]=new int[n], wt[]=new int[n]; double avgTAT=0, avgWT=0;
        System.out.println("
PID	AT	BT	CT	TAT	WT");
        for(int i=0;i<n;i++){
            tat[i]=ct[i]-at[i]; wt[i]=tat[i]-bt[i];
            avgTAT+=tat[i]; avgWT+=wt[i];
            System.out.println(pid[i]+"	"+at[i]+"	"+bt[i]+"	"+ct[i]+"	"+tat[i]+"	"+wt[i]);
        }
        System.out.println("Average TAT="+(avgTAT/n)+" Average WT="+(avgWT/n));
    }

    // ================= MAIN MENU ==================
    public static void main(String[] args) {
        int choice;
        do {
            System.out.println("
--- CPU Scheduling Algorithms ---");
            System.out.println("1. FCFS");
            System.out.println("2. SJF (Preemptive)");
            System.out.println("3. Priority (Non-Preemptive)");
            System.out.println("4. Round Robin (Preemptive)");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            choice = sc.nextInt();
            switch(choice){
                case 1: fcfs(); break;
                case 2: sjfPreemptive(); break;
                case 3: priority(); break;
                case 4: roundRobin(); break;
                case 5: System.out.println("Exiting..."); break;
                default: System.out.println("Invalid Choice");
            }
        } while(choice != 5);
    }
}

