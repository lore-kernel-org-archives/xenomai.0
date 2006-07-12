Message-ID: <b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
Date: Wed, 12 Jul 2006 14:00:04 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
In-Reply-To: <44B4C09F.209@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_89214_30556199.1152705604407"
References: <44B4C09F.209@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_89214_30556199.1152705604407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,


given the existing doc of rt_task_suspend about allowed environments and
> also when thinking about the logic behind it, I see no reason why
> xnpod_unblockable_p() is also applied to task != NULL.



XNLOCK is set? anyway, I don't see how the patch makes current logic
different...

in both cases xnpod_unblockable_p() has a chance to be executed only when
task != NULL (thanks to goto). and -EPERM is returned when task != NULL &&
xnpod_unblockable_p() == true.


        if (!task) {
>                 err = xeno_handle_error(task, XENO_TASK_MAGIC, RT_TASK);
>                 goto unlock_and_exit;
> -       }
> -
> -       if (xnpod_unblockable_p()) {
> +       } else if (xnpod_unblockable_p()) {
>                 err = -EPERM;
>                 goto unlock_and_exit;
>         }
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_89214_30556199.1152705604407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
Hi,<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">given the existing doc of rt_task_suspend about allowed environments and<br>also when thinking about the logic behind it, I see no reason why
<br>xnpod_unblockable_p() is also applied to task != NULL.</blockquote><div><br>
<br>
XNLOCK is set? anyway, I don't see how the patch makes current logic different...<br>
</div><div><br>
in both cases xnpod_unblockable_p() has a chance to be executed only
when task != NULL (thanks to goto). and -EPERM is returned when task !=
NULL &amp;&amp; xnpod_unblockable_p() == true.<br>
&nbsp;<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!task) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;err
= xeno_handle_error(task, XENO_TASK_MAGIC, RT_TASK);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto unlock_and_exit;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xnpod_unblockable_p()) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (xnpod_unblockable_p()) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;err = -EPERM;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto unlock_and_exit;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_89214_30556199.1152705604407--

