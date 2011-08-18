Message-ID: <4E4D60C9.1020409@domain.hid>
Date: Thu, 18 Aug 2011 14:58:17 -0400
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] odd code for loopback option in
	/src/utils/can/rtcansend.c
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

In xenomai-2.5.5.2/src/utils/can/rtcansend.c, the code that handles 
local loopback mode looks like this:

static void print_usage(char *prg)
{
...
             " -L, --loopback=0|1    switch local loopback off or on\n"
...
}

static int loopback=-1;

         switch (opt) {
	...
         case 'L':
             loopback = strtoul(optarg, NULL, 0);
             break;
	...
	}

...
     if (loopback >= 0) {
         ret = rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
                                 &loopback, sizeof(loopback));
         if (ret < 0) {
             fprintf(stderr, "rt_dev_setsockopt: %s\n", strerror(-ret));
             goto failure;
         }
         if (verbose)
             printf("Using loopback=%d\n", loopback);
     }

It looks like the default value for loopback is -1, and if you set it to 
0 or 1, it turns loopback on, which seems strange.  I don't understand 
rt_dev_setsockopt() fully, so I'm not sure if it's a bug - I don't know 
if -1 and 0 and 1 are three separate loopback states, but I think it 
merits attention.  I think either the code is wrong or the help string 
and man page are not clear.

-Andy

