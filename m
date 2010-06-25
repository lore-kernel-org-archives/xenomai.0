Message-ID: <4C249D4B.7000303@domain.hid>
Date: Fri, 25 Jun 2010 14:12:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>	<4C23B213.5080103@domain.hid>	<AANLkTimofdDy_OSC6dr_2l4X8vAn8oPsQdqVXrSWZ-2e@domain.hid>
	<AANLkTikA0fz6Rt8-4NqaOGL7_b_UdbVzSXCRYxg8J68h@domain.hid>
In-Reply-To: <AANLkTikA0fz6Rt8-4NqaOGL7_b_UdbVzSXCRYxg8J68h@domain.hid>
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
> And a last one (for now ...), I read here  :-
> http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
> that :
> /"When a realtime
> task executes into the Linux domain on a given processor, the
> Linux kernel as a whole inherits the realtime
> priority of such task, and thus
> competes for the CPU resource by priority with other realtime
> tasks regardless of
> the domain (i.e. Linux or Xenomai) they happen to belong to. In other
> words, the
> realtime
> priority scheme enforced by the native API is consistent across domains. "/
> 
> I was thinking that Linux were a process of Xenomai with the lowest
> effective priority, and a task in secondary mode were only in
> competition with the others Linux threads (or others Xenomai thread in
> 2ndary mode). But if I'm wrong, how can the 2 schedulers share
> ressources in order to keep a hard real-time behaviour (at less for
> Xenomai tasks in 1st mode).

I am not sure I understand your question.

The two schedulers do not share ressources. What is meant by this
sentence is that the Linux kernel is a task, from Xenomai scheduler's
point of view, and this tasks inherits the priority of Xenomai tasks
running in secondary mode. The Linux scheduler is not involved.

And giving to a task running in secondary mode a priority higher than a
task running in primary mode looks like a design error anyway.

If you do not like this behaviour, you can disable it, but, on the whole
it makes things a little more natural.

-- 
					    Gilles.

