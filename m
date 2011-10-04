MIME-Version: 1.0
In-Reply-To: <4E8AEB1D.2060706@domain.hid>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
Date: Tue, 4 Oct 2011 09:06:16 -0400
Message-ID: <CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
From: Julien Delange <julien.delange@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

On Tue, Oct 4, 2011 at 7:16 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> I am sorry, I do not really understand what you are doing, what has
> CONFIG_HZ to do with your issue?

I was wondering if this configuration item may have an impact on the
kernel scheduling speed.


> Could you post a self-contained example allowing to reproduce the issue
> you observe?

So, basically, I just create a start a native xenomai thread :
   rt_task_create(&task, "Read IO Card", 0, 99, T_FPU);
   rt_task_start (&task, &polling_task, 0);


And then, the task itself performs a loop that acquires data on a
periodic basis of 1ms (see code below).
The problem is that when I run the code, the value of missed in either
1 or 2, meaning that the deadline expired and the task does not meet
its timing requirements.

So, if you have any suggestion/comments to improve this code or how
kernel configuration may impact the performance of such piece of code,
it would be very interesting.



void polling_task(void * arg)
{
   int                      i;
   double                tmp;
   int                     ret;
   uint8_t               raw[128 * 16];
   double               rate = 0.0001;
   int                      result;
   unsigned long     missed;
   a4l_insn_t          insn_tab[16];
   a4l_insnlst_t       insnlst;


   insnlst.count = 16;
   insnlst.insns = insn_tab;

   for (i=0; i<16; i++)
   {
      insn_tab[i].type             = A4L_INSN_READ;
      insn_tab[i].idx_subd      = 0;
      insn_tab[i].chan_desc   = chdesc[i];
      insn_tab[i].data_size     = 8;
      insn_tab[i].data             = &raw[128 * i];
   }
   rt_task_set_periodic(NULL, TM_NOW, rate * 1000000000.0);
   rt_task_set_mode (0,T_LOCK|T_PRIMARY|T_NOSIG|T_RPIOFF, NULL);
   while(1)
   {
      result = rt_task_wait_period(&missed);
      if (result == -ETIMEDOUT)
      {
         printf("Number of missed deadlines: %lu \n", missed);
      }

      ret = a4l_snd_insnlist(&device, &insnlst);
      if (ret != 0)
      {
         printf("insnlist error: %d \n", ret);
      }
      for (i=0; i<16; i++)
      {
         ret = a4l_rawtod (chinfos[i], rnginfos[i], &tmp, &raw[i*128], 1);
         if (ret <= 0)
         {
            printf("rawtod() error: %d\n", ret);
         }
   }
   return;
}

