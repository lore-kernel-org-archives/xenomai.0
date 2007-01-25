Subject: Re: [Xenomai-help] printf() allowed in xenomai?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45B89A61.7000509@domain.hid>
References: <45B89438.4000806@domain.hid>
	<1169725412.5028.33.camel@domain.hid>  <45B89A61.7000509@domain.hid>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 13:26:35 +0100
Message-Id: <1169727995.5028.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On Thu, 2007-01-25 at 12:54 +0100, Steven Scholz wrote:
> Philippe,
> 
> >> I wonder if there exists a document that describes to Dos and Donts when
> >> programming real time applications with Xenomai.
> > 
> > This is a good starting point, discussing about basic issues to keep in
> > mind when using something based on a co-kernel technology:
> > http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Native-API-Tour.pdf
> > http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Life-with-Adeos.pdf
> 
> Thanks!
> 
> >> For excample is it allowed to used glibc funkctions like printf()?
> > 
> > Yes, but time-wise, this costs you predictability. You may want to grep
> > the mailing list archive about "secondary mode switch" and the like.
> 
> Would you please state in one line what "secondary mode switch" means?
> Is it the switch from xenomai to linux?
> 

>From the xenomai scheduler to the Linux scheduler, yes. You should find
some insights about this in the tech. articles  I just mentioned.

> Steven
-- 
Philippe.



