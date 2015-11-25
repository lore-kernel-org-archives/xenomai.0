References: <trinity-1831e513-92b7-4257-8f4e-a09952d12ad0-1448472034310@3capp-webde-bap53>
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <5655F292.7080209@sigmatek.at>
Date: Wed, 25 Nov 2015 18:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <trinity-1831e513-92b7-4257-8f4e-a09952d12ad0-1448472034310@3capp-webde-bap53>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] how to force task switch to primary mode
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

Am 25.11.2015 um 18:20 schrieb JK.Behnke@web.de:
>     Hello,
>
>     an rtdm driver that I use requires the rt_dev_open call to be executed
>     in primary mode.
>     With xenomai 2.4.2 it was possible to switch to primary mode using
>     rt_task_set_mode(0, T_PRIMARY, NULL);
>
>     Now I use xenomai 2.6.3, but I can't find the T_PRIMARY flag.
>     Is there an other alternative to force the task to switch to primary
>     mode?
>
>     Would I have to change the rtdm driver, so xenomai performs the mode
>     switch automatically?
>
>     Thanks in advance for any hint.
>     Jochen
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
in the file API.CHANGES:
2.5.5 -> 2.6.0

        * rt_task_set_mode() does not support the T_PRIMARY bit
          anymore; the latter has been replaced by T_CONFORMING, which
          is allowed in the setmask only, and only effective for
          real-time shadows.

      In other words,

      - rt_task_set_mode(clrmask, setmask=T_PRIMARY, &oldmode)
        becomes:
        rt_task_set_mode(clrmask, setmask=T_CONFORMING, &oldmode),
        forcing primary mode only for SCHED_FIFO Xenomai threads
        only. Nop otherwise (i.e. a non real-time shadow remains
        in relaxed mode after the syscall has returned, since this
        is its conforming runtime mode).

      - rt_task_set_mode(clrmask=T_CONFORMING, setmask, &oldmode)
      always begets -EINVAL.

Regards
   Johann

