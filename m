Message-ID: <4E1AFA51.3090209@domain.hid>
Date: Mon, 11 Jul 2011 15:27:45 +0200
From: Kim Mathiassen <kimmat@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problem with periodic posix thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I have som problems creating a periodic posix thread. When I call 
pthread_make_periodic_np it returns 3 (ESRCH). I have created the 
following test:

void *thread()
{
   while(1)
   {
     pthread_wait_np(NULL);
     printf("Test\n");
   }
}

int main()
{
   pthread_t t;

   pthread_create(&t, NULL, thread, NULL);

   struct timespec start, period;
   clock_gettime(CLOCK_REALTIME, &start);
   period.tv_sec = 10;
   period.tv_nsec = 0;

   int error = pthread_make_periodic_np(t, &start, &period);
   printf("%i\n",error);

   if ( error == 0 )
     pthread_join(t, NULL);
}

Why does it fail?

Kim Mathiassen

