MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <4B0413DC.6090603@domain.hid>
References: <4B0413DC.6090603@domain.hid>
Date: Wed, 18 Nov 2009 18:35:56 +0100
Message-ID: <72cf3fb0911180935l49de171cr8f77d32921be124d@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Analogy Sensoray s526
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Wed, Nov 18, 2009 at 4:33 PM, Alessio Margan @ IIT
<alessio.margan@domain.hid> wrote:
> Hi,
> I'm new to Xenomai and I am a bit confused about the status of Analogy.

You can follow this thread:
https://mail.gna.org/public/xenomai-help/2009-11/msg00083.html

I am aware that documentation is lacking, I am trying to fix that point.

> One project in our lab
> http://www.iit.it/en/advanced-robotics/projects/hydraulically-actuated-quadruped-hyq.html
> needs real time capabilities and due to hw configuration (pc104 cpu
> board + 1 to 5 s526 Sensory boards) we choose RTAI+COMEDI.
> We would like to switch to Xenomai, the Sensory s526 board will be
> supported ?
> With Xenomai-abe tree could I use the comedi kernel module for s526 ?

We plan to add, in analogy, a compatibility layer with comedi. That is
not available yet. So, you cannot use the comedi kernel module s526 in
a real-time context.

However, if you like kernel programming, the comedi -> analogy port is
quite easy to perform.

The last solution: I can add the port in my TODO list. In such a case,
I just have one request:
- Are you OK with testing and validating the analogy driver on your
system (I do not own this card)?

Alexis.

