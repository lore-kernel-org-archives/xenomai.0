MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Tue, 24 Jul 2018 18:22:06 +0530
Message-ID: <CAFUnMkn_+VVe63etwY7x917idQ6EODQ9WmykGrcPoimAg=NjDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] task sleep time is getting added when I move my mouse
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I mention below a sample code of my project using soem I use the task
function as below.

ret4 =3D rt_task_create(&Dc_Pll_task, "Dc_time_Pll_task", 0, 99, 0);


void Dc_time_Pll_function()
{

     struct timespec   ts, tleft;

     static int64 integral =3D 0;

     int64 sec, nsec,delta, cycletime=3D1000000;

     clock_gettime(CLOCK_MONOTONIC, &ts);
     while(1)
     {
             previous1 =3D rt_timer_read();   //read time

             input_ek1818  =3D (Ek1818_data_inputt *)
ec_slave[slave_pos_beck_digitalIO].inputs;//struct
pointers to slave I/O pointers inputs//
             output_ek1818 =3D (Ek1818_data_outputt*) ec_slave[slave_pos_be=
ck_
digitalIO].outputs;
             in_EL5101     =3D (in_EL5101t*) ec_slave[slave_pos_beck_
encoderinterface].inputs;
             out_EL5101    =3D (out_EL5101t*) ec_slave[slave_pos_beck_
encoderinterface].outputs;

             nsec =3D (cycletime + offsettime) % NSEC_PER_SEC;
             sec  =3D ((cycletime + offsettime) - nsec) / NSEC_PER_SEC;

             ts.tv_sec +=3D sec;
             ts.tv_nsec +=3D nsec;

             if (ts.tv_nsec >=3D NSEC_PER_SEC )
             {
               nsec =3D ts.tv_nsec % NSEC_PER_SEC;
               ts.tv_sec +=3D (ts.tv_nsec - nsec) / NSEC_PER_SEC;
               ts.tv_nsec =3D nsec;
             }
             clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts,
&tleft);
           // Loop user code here

        if (ec_slave[0].hasdc)
            {
          //ec_Dctime is the system time synchronised with Ethercat
slave
              delta =3D (ec_DCtime -(cycletime/4)) % cycletime;
                  if(delta > (cycletime / 2))
                  {
                       delta=3D delta - cycletime;
                  }

                 if(delta>0)
                  {
                       integral++;
                  }

                 if(delta<0)
                  {
                      integral--;
                  }
                  offsettime =3D -(delta / 100) - (integral / 20);
            }

    }
}

and I am using clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts,
&tleft);     to wait for a time untill the sleep wakes up this routine
works good,

but when I move a mouse the clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME,
&ts, &tleft);  gets some amount of microsecond added then, and my ethercat
slave loss frame but the slave is synchronised with master.


can anybody solve the problem such that when I move my mouse or keyboard
clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, &tleft);  nanosleep
time should not get jumped or time get added to it so that


I dont loss any ethercat frames.

ret4 =3D rt_task_create(&Dc_Pll_task, "Dc_time_Pll_task", 0, 99, 0);
and the task priority I set is high.


Thank you

R. Ashokkumar





=E2=80=8C
<https://mailtrack.io/> Sent with Mailtrack
<https://chrome.google.com/webstore/detail/mailtrack-for-gmail-inbox/ndnaeh=
gpjlnokgebbaldlmgkapkpjkkb?utm_source=3Dgmail&utm_medium=3Dsignature&utm_ca=
mpaign=3Dsignaturevirality>
