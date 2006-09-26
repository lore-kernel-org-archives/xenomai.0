Message-ID: <20060926154124.45256.qmail@domain.hid>
Date: Tue, 26 Sep 2006 08:41:24 -0700 (PDT)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1120411631-1159285284=:44571"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-core] aperiodic xenomai tasks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0-1120411631-1159285284=:44571
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi friends
i want to create two aperiodic tasks .I have made a small example and created two tasks and set their priority equal.i have removed rt_task_setPeriodic function from the code but problem is that the task which is started first only it works and the second task which is started later never shows up.If some one tells me the cause of this problem i would be very grateful.The source code is given below.

void zaehler1_task(void *cookie){
        int ret;

// ************************* Xenomai-Krempel ********************************************************************
    //    ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns1));
    //    if (ret) {
    //            printf("error while set periodic, code %d\n",ret);
    //            return;
    //    }
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
        while(!end){
                ret = rt_task_set_mode(0, T_PRIMARY, NULL);
                if (ret) {
                        printf("error while rt_task_set_mode, code %d\n",ret);
                        return;
                }
                ret = rt_task_wait_period();
                printf("T1:Start\n");

                if (ret) {
                //        printf("error while rt_task_wait_period, code %d\n",ret);
                //        return;
                }
                count1++;

                printf("T1:Ende:%d\n", count1);

                fflush(NULL);
        }
// ********************** Ende des wiederholt ausgefuehrten Codes ***********************************************
}

void zaehler2_task(void *cookie){
        int ret;
        long ii;
        long jj;
        double a;

// ************************* Xenomai-Krempel ********************************************************************
//      ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns2));
//      if (ret) {
//              printf("error while set periodic, code %d\n",ret);
//              return;
//      }
// ************************* Ende Xenomai-Krempel ****************************************************************

// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
        while(!end){
                ret = rt_task_set_mode(0, T_PRIMARY, NULL);
                if (ret) {
                        printf("error while rt_task_set_mode, code %d\n",ret);
                        return;
                }
                ret = rt_task_wait_period();

                printf("\t\tT2:Start\n");

                if (ret) {
                //      printf("error while rt_task_wait_period, code %d\n",ret);
                //      return;
                }

            //    for(ii=0; ii<200; ii++) {
                //      for(jj=0; jj<1000000; jj++) {
                //              a = (double)ii * (double)jj;
                //      }
        //      }

                count2++;
                printf("\t\tT2:Ende:%d\n", count2++);

                fflush(NULL);
        }
// ********************** Ende des wiederholt ausgefuehrten Codes **


int main(int argc, char *argv[]) {
        int err, ret;
        printf("start\n");
        // install signal handler
        signal(SIGTERM, clean_exit);
        signal(SIGINT, clean_exit);
        // start timer
        ret = rt_timer_start(TM_ONESHOT);
        switch (ret) {
                case 0:       printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");
                              break;
                case -EBUSY:  printf("timer is running\n");
                              break;
                case -ENOSYS: printf("can't start timer\n");
                              return ret;
        }

        /* create zaehler1_task */
        err = rt_task_create(&zaehler1_task_ptr,"Zaehler_1",STACK_SIZE,STD_PRIO1,0);
        /* create zaehler2_task */
        err = rt_task_create(&zaehler2_task_ptr,"Zaehler_2",STACK_SIZE,STD_PRIO2,0);

        /* start zaehler1_task */
        err = rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);

        /* start zaehler2_task */
        err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

        // wait for signal & return of signal handler
        pause();
        fflush(NULL);
}







 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
--0-1120411631-1159285284=:44571
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi friends<br>i want to create two aperiodic tasks .I have made a small example and created two tasks and set their priority equal.i have removed rt_task_setPeriodic function from the code but problem is that the task which is started first only it works and the second task which is started later never shows up.If some one tells me the cause of this problem i would be very grateful.The source code is given below.<br><br>void zaehler1_task(void *cookie){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br><br>// ************************* Xenomai-Krempel ********************************************************************<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns1));<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; if (ret) {<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while set periodic, code %d\n",ret);<br>&nbsp;&nbsp;&nbsp;
 //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; }<br>// ************************* Ende Xenomai-Krempel ****************************************************************<br><br><br>// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(!end){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_task_set_mode(0, T_PRIMARY, NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while rt_task_set_mode, code
 %d\n",ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_task_wait_period();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("T1:Start\n");<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while rt_task_wait_period, code %d\n",ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count1++;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("T1:Ende:%d\n", count1);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fflush(NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>// ********************** Ende des wiederholt ausgefuehrten Codes ***********************************************<br>}<br><br>void zaehler2_task(void *cookie){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long ii;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long jj;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double a;<br><br>// ************************* Xenomai-Krempel
 ********************************************************************<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns2));<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while set periodic, code %d\n",ret);<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>// ************************* Ende Xenomai-Krempel ****************************************************************<br><br>// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(!end){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_task_set_mode(0, T_PRIMARY,
 NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while rt_task_set_mode, code %d\n",ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_task_wait_period();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("\t\tT2:Start\n");<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("error while rt_task_wait_period, code %d\n",ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; for(ii=0; ii&lt;200; ii++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(jj=0; jj&lt;1000000; jj++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a = (double)ii *
 (double)jj;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count2++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("\t\tT2:Ende:%d\n", count2++);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fflush(NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>// ********************** Ende des wiederholt ausgefuehrten Codes **<br><br><br>int main(int argc, char *argv[]) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err, ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("start\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // install signal handler<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 signal(SIGTERM, clean_exit);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, clean_exit);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // start timer<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_timer_start(TM_ONESHOT);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ret) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case -EBUSY:&nbsp; printf("timer is
 running\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case -ENOSYS: printf("can't start timer\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create zaehler1_task */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;zaehler1_task_ptr,"Zaehler_1",STACK_SIZE,STD_PRIO1,0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create zaehler2_task */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
 rt_task_create(&amp;zaehler2_task_ptr,"Zaehler_2",STACK_SIZE,STD_PRIO2,0);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* start zaehler1_task */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_start(&amp;zaehler1_task_ptr,&amp;zaehler1_task,NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* start zaehler2_task */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_start(&amp;zaehler2_task_ptr,&amp;zaehler2_task,NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // wait for signal &amp; return of signal handler<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pause();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fflush(NULL);<br>}<br><br><br><br><br><br><br><p>&#32;
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> 

--0-1120411631-1159285284=:44571--

