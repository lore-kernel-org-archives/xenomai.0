Message-ID: <4C231E47.7070000@domain.hid>
Date: Thu, 24 Jun 2010 10:58:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
In-Reply-To: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Some questions about Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Clerdan <charles.clerdan@domain.hid>
Cc: xenomai@xenomai.org

Charles Clerdan wrote:
> Hi,
> 
> I'm actually working on an academic project about Real-Time on Xenomai.
> I have some questions about Xenomai (for all of them, the application is
> in user-space).
> 
> How can we use gdb with a RT application? (I understand that, a Xenomai
> thread has no PID because it's use a TASK descriptor instead but gdb
> needs a PID to attach with)
> 
> How can I detect that a Xenomai thread is in secondary mode (I try to
> use RT_TASK_INFO but the value is always 0 even if I do non-RT call) ?
> And does a mecanism like assertion exist in order to prevent this?
> 
> I want to make an IT server as exemple, how can I get back some IT or
> generate them from the ADEOS' I-pipe ?

Please come back after you have read the documents here:
http://www.xenomai.org/index.php/Publications

-- 
					    Gilles.

