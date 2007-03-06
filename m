Message-ID: <bc4264770703060723i66a0fa71sb138c0f2c839b314@domain.hid>
Date: Tue, 6 Mar 2007 15:23:51 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN problem continued
In-Reply-To: <E1HObQ1-00073u-B9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060003t2f7a9555o27a0f26df5a43205@domain.hid>
	<E1HObDh-00060e-TM@mailer.emlix.com>
	<bc4264770703060710l792d6173v9aec4bfeff0715d3@domain.hid>
	<E1HObQ1-00073u-B9@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Hi

On 3/6/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> roland Tollenaar wrote:
> > > Could you do the following: Fire up rtcanrecv and send out the setup
> > > message to the node with rtcansend. Don't start your application during
> > > the whole time and watch what happens.
> > >
> > :( Its not one message, its about 6 can rtcanrecv run scripts?

Ok done with rtcansend and rtcanrecv. Perfect behavior i.e exactly the
same behaviour as I get when i run my applicaiton. Obviously there is
no indication as to the real-time disruptiveness because I can only
see that from my application. Which is not running.

>
> I don't understand exactly. Could you elaborate on what is necessary to get
> the node up?

pre-operational state,  then 4 SDO messages to set it into continuous
sending @ 1ms.

I have also turned off bits of my code here andd there to ensure that
it is not my processing that can be doingthis. But there is no
processing, there is only reading.

Regards,

Roland





>
> --
> Sebastian
>

