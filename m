MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 20 Apr 2020 12:49:38 +0800
Message-ID: <CAAvDm6bPuRWZUvdazP=_at0WpLYWp3A8fXXwNU8EWJdguGzabw@mail.gmail.com>
Subject: =?UTF-8?B?SSB3b25kZXIgd2hhdCDigJxhcGPigJ0gc3RhbmRzIGZvcj8=?=
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
To: xenomai <xenomai@xenomai.org>

Hi,
       I wonder what =E2=80=9Capc=E2=80=9D stands for?
       There are some fileds  named start with "apc"  in struct
cobalt_pipeline.
       For instance, "apc_virq"=E3=80=81" apc_map"=E3=80=81" apc_table".

       For your convenience, I listed the struct mentioned in this email.

      struct cobalt_pipeline {

   struct ipipe_domain domain;
   unsigned long timer_freq;
   unsigned long clock_freq;
   unsigned int apc_virq;
   unsigned long apc_map;
   unsigned int escalate_virq;
   struct {
      void (*handler)(void *cookie);
      void *cookie;
      const char *name;
   } apc_table[BITS_PER_LONG];
#ifdef CONFIG_SMP
   cpumask_t supported_cpus;
#endif
};


   Thanks for your attention.

   Looking forward to hearing from you.
