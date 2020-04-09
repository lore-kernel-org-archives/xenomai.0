MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
In-Reply-To: <20200409201057.74CB5ED0@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 9 Apr 2020 20:48:31 +0200
Message-ID: <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Thu, Apr 9, 2020 at 8:10 PM Petr =C4=8Cervenka <grugh@centrum.cz> wrote:
>
> > Don't use signal().
> > Use sigaction() and *don't* set SA_RESTART. Maybe read() is always rest=
arted...
>
>
>
> Thank you for trying to help me.
>
> But with the sigaction (without SA_RESTART) the behavior is completely th=
e same:
>
> Only Ctrl+C or kill(0, SIGINT) are able to invoke the signalHandler.
> The read() is not interrupted (maybe syscall restart in some inner cycle)=
.
>
> Example of the signal handler setup:
>
>     // Setup signal handler
>     struct sigaction act;
>     memset(&act, 0, sizeof (act));
>     act.sa_handler =3D signalHandler;
>     sigaction(SIGINT, &act, NULL);
>     sigaction(SIGTERM, &act, NULL);

I gave your program a try.
With this changes it works (at least how I understand your test case).

Task started
Set period: 5s
Task livind: 9.9e-05s
Waiting for join
Signal handler: 41
Signal handler end
Task livind: 0.999s
Task ended

diff --git a/read_intr.cpp b/read_intr.cpp
index 722f69c..1c5ef53 100644
--- a/read_intr.cpp
+++ b/read_intr.cpp
@@ -21,14 +21,10 @@ static pthread_t task;
 static int timer_fd;
 static bool end =3D false;

-void signalHandler(int signal) {
+void signalHandler(int signal, siginfo_t *info, void *ctx) {
     int err;
     printf("Signal handler: %d\n", signal);
     end =3D true;
-    err =3D pthread_kill(task, SIGINT);
-    if (err !=3D 0) {
-        printf("pthread_kill failed: %d (%s)\n", err, strerror(-err));
-    }
     printf("Signal handler end\n");
 }

@@ -50,9 +46,6 @@ static void *taskHandler(void *cookie) {

     printf("Task started\n");

-    signal(SIGINT, signalHandler);
-    signal(SIGTERM, signalHandler);
-
     // Get current time
     struct timespec start;
     clock_gettime(CLOCK_MONOTONIC, &start);
@@ -97,13 +90,15 @@ static void *taskHandler(void *cookie) {
 int main(int argc, char** argv) {
     unsigned long overruns;
     int err;
+    struct sigaction sa =3D {0};

     mlockall(MCL_CURRENT | MCL_FUTURE);

     // Setup signal handler
-    signal(SIGINT, signalHandler);
-    signal(SIGTERM, signalHandler);
-
+    sa.sa_flags =3D 0;
+    sigemptyset(&sa.sa_mask);
+    sa.sa_sigaction =3D signalHandler;
+    sigaction(SIGRTMIN + 7, &sa, NULL);
     // Get current process ID
     mainTask_pid =3D getpid();

@@ -140,11 +135,11 @@ int main(int argc, char** argv) {
     usleep(SLEEP / 1000);

     // Call of signal handler
-    err =3D kill(0, SIGINT);  // THE ONLY ONE WHICH WORKS !!!
+    //err =3D kill(0, SIGINT);  // THE ONLY ONE WHICH WORKS !!!
     //err =3D kill(getpid(), SIGINT);
     //err =3D kill(mainTask_pid, SIGINT);
     //err =3D pthread_kill(pthread_self(), SIGINT);
-    //err =3D pthread_kill(task, SIGINT);
+    err =3D pthread_kill(task, SIGRTMIN + 7);
     if (err !=3D 0) {
         printf("pthread_kill failed: %d (%s)\n", err, strerror(-err));
     }


--=20
Thanks,
//richard

