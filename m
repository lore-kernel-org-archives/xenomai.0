Date: Wed, 27 Apr 2011 15:06:40 +0200 (CEST)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <5589457.21303909599062.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <30435812.01303909424265.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1_22346661.1303909599062"
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
 destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_1_22346661.1303909599062
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> Do you have the same issue with the latest version of the branch you 
> use? That is 2.5.6? 

Hi, 

Xenomai 2.5.6 on 2.6.35.9 kernel, IPipe patch 2.8-04 has same behavior. 

Now I'm compiling 2.6.37 kernel with 2.9-00 IPipe patch, I'll try it and give you results. 


> Has not pthread_join alone the same behaviour? 

Yes, in past I got this behavior on pthread_join()/rt-task_join(), work-arounded without using T_JOINABLE flag. 



------=_Part_1_22346661.1303909599062
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'>&gt; Do you have the same issue with the latest version of the branch you<br>&gt; use? That is 2.5.6?<br><br>Hi,<br><br>Xenomai 2.5.6 on 2.6.35.9 kernel, IPipe patch 2.8-04 has same behavior.<br><br>Now I'm compiling 2.6.37 kernel with 2.9-00 IPipe patch, I'll try it and give you results.<br><br><br>&gt; Has not pthread_join alone the same behaviour?<br><br>Yes, in past I got this behavior on pthread_join()/rt-task_join(), work-arounded without using T_JOINABLE flag.<br><br><br></div></body></html>
------=_Part_1_22346661.1303909599062--

