Date: Mon, 20 Mar 2006 19:01:15 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200603201901.3123@domain.hid>
References: 200603201434.15258@domain.hid> <200603201434.15258@domain.hid>
	<441ED657.1080405@domain.hid>
In-Reply-To: <441ED657.1080405@domain.hid>
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

I' tried to create  user realtime task, and after all effort (and many related partial problems solved) I still cannot do blocking variant of rtdm_event_timedwait.
1) How can I recognize, that the function is called within proper context / ie. is there an rtdm equivalent to xnpod_unblockable_p?
2) Could be the problem elsewhere?
3) My General Standards PCI-24DSI-12 card is not supported by comedi. And I'm not familiar with it either. The original driver is not so complicated and the port looked as easy work ;-) But waiting inside ioctl or read handler for an interrupt is critical for proper functionality.
4) I realized when I make a realtime task (prio 1 ~ lowest, I hope) and in my main (nrt) task I call sleep(1), It will fall asleep forever (or maybe to some signal).
5) Is it possible to set some event or to send signal/message/... from rt to nrt and back?
6) Is there some easy-to-understand documentation? What I can or cannot...?
Petr Cervenka

>
>  Petr Cervenka wrote:
> > Hello,
> > I'm trying to port a  driver of a AD card to RTDM.
> 
> The discussion around blockable contexts made me forget to ask some
> question:
> 
> I heard rumours of some COMEDI (www.comedi.org) port over RTDM recently,
> don't know the current status. Anyway, have you considered that
> abstraction model for your driver? Is there already a COMEDI driver for
> your card in COMEDI? Maybe it's more useful then to through all efforts
> together and get a generic solution running.
> 
> Jan
> 
> 
> 


