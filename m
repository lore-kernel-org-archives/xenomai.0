Date: Thu, 10 Feb 2011 16:20:17 +0100 (CET)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <7679056.61297351216093.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <21381658.41297350790328.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3_18595445.1297351216093"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
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

------=_Part_3_18595445.1297351216093
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello to all, 
finally I found a bug into my code which is not related with join functions. Now all works fine. Thank you for support (and tolerate) me! 

I have one just one last question (another!) to you: 
I create a pthread with joinable attribute, and then I transform it in a realtime ask with rt_task_shadow(). 
When I join this task I must call pthread_join(), because rt_task_join() generates a segmentation fault (in the point where latter function internally calls pthread_join()). 
Is this behaviour correct? 

Thanks again in advance, regards 
Mauro 

------=_Part_3_18595445.1297351216093
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'>Hello to all,<br>finally I found a bug into my code which is not related with join functions. Now all works fine. Thank you for support (and tolerate) me!<br><br>I have one just one last question (another!) to you:<br>I create a pthread with joinable attribute, and then I transform it in a realtime ask with rt_task_shadow().<br>When I join this task I must call pthread_join(), because rt_task_join() generates a segmentation fault (in the point where latter function internally calls pthread_join()).<br>Is this behaviour correct?<br><br>Thanks again in advance, regards<br>Mauro<br></div></body></html>
------=_Part_3_18595445.1297351216093--

