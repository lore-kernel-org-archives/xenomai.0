From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
Date: Tue, 6 Mar 2007 16:35:20 +0100
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HObQ1-00073u-B9@domain.hid>
	<bc4264770703060723i66a0fa71sb138c0f2c839b314@domain.hid>
In-Reply-To: <bc4264770703060723i66a0fa71sb138c0f2c839b314@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HObh1-0008VE-H3@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi
>
> On 3/6/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > roland Tollenaar wrote:
> > > > Could you do the following: Fire up rtcanrecv and send out the setup
> > > > message to the node with rtcansend. Don't start your application
> > > > during the whole time and watch what happens.
> > > >
> > > :( Its not one message, its about 6 can rtcanrecv run scripts?
>
> Ok done with rtcansend and rtcanrecv. Perfect behavior i.e exactly the
> same behaviour as I get when i run my applicaiton. Obviously there is
> no indication as to the real-time disruptiveness because I can only
> see that from my application. Which is not running.

So let me summarise:
- With rtcansend/rtcanrecv and without your application the communication with 
the node is perfect (overflows?)
- With your application running you state that the real-time behaviour of the 
system is bad. How do you detect this?

-- 
Sebastian

