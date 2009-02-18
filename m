Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>
	<200902170940.54910.peter.soetens@domain.hid>
	<499A8636.5020100@domain.hid>
	<200902171208.07297.peter.soetens@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 18 Feb 2009 02:20:16 +0100
In-Reply-To: <200902171208.07297.peter.soetens@domain.hid> (Peter Soetens's
	message of "Tue\, 17 Feb 2009 12\:08\:07 +0100")
Message-ID: <87y6w4r167.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Peter Soetens <peter.soetens@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org


Hi,

Peter Soetens <peter.soetens@domain.hid> writes:

> On Tuesday 17 February 2009 10:41:10 Jan Kiszka wrote:
>> Peter Soetens wrote:
>> > These are the facts we observed:
>> >
>> > * The Xenomai/Comedi port breaks the complete Comedi API, user space
>> > *and* kernel space. (We thought/assumed that only the user space
>> > interface would go over RTDM and that once that was done, the kernel
>> > modules could be almost copy/pasted into the new framework.)
>>
>> Maybe you have a list of the major differences. Then please share it so
>> that the motivation can be discussed here and maybe clarified (it's a
>> blurred topic for me as well).
>
> Damn. I should have posted back then :-) Our main lead was the Doxygen pages, 
> from which we went on to see how things were done in code. Unfortunately (?), 
> I'm not a Comedi developer, I twiddled only with one Comedi driver. Once. I 
> can't really compare to the bone. But what was clear immediately was that both 
> user API and kernel API were different. 
>
> User ('Library') API was cleaned up and streamlined, we could live with that 
> for new applications. I'm sure there are still issues, but they'll only come 
> up once people start using this branch. I like the separation between a low 
> level 'instruction' api and a high level 'function' api. Something upstream 
> comedi mixes to much.
>
> For kernel ('Driver') API, a new data transfer mechanism is in place, which 
> requires the 'porting' of all drivers. I genuinely can't estimate how 
> drastically this changes existing drivers, but the API is quite huge and works 
> with the 'inversion of control' paradigm: Each driver must implement a series 
> of hooks, and the Comedi/RTDM framework will call these when necessary.

Just to sum-up why the whole Comedi API suffers so many changes from
the upstream Comedi API (sorry for 'legacy'):

* At the very beginning (If I remember well), I just wanted to port
  the current Comedi layer so as to comply with RTDM API. My first
  resolution was to leave the drivers set unchanged so as to
  seamlessly use them in the ported framework. However, I was facing
  many issues (RT/NRT contexts, mix with kernel API, etc.) I could not
  handle without altering drivers code. Eventually, I was unable to
  provide a coherent RTDM Comedi module considering the code
  organization.

* That was the point which makes try to overhaul the original
  branch. I sent an email on the Comedi mailing list. I received no
  answer; by the way, the activity seemed quite low. I wanted to
  develop a Comedi infrastructure usable on both configurations
  (common Linux API and RTDM). Fulfilling such a constraint led me to
  redefine the kernel driver API. Before integrating the code into
  Xenomai's trunk, I decided to drop the common Linux interface while
  keeping in mind that the RTDM-native module would allow the new
  Comedi core to run on common kernels (maybe that was a
  mistake). That is why, the driver API still have the context notion;
  I should remove it.

Then I did my best to design a coherent layer. There are still many
flaws to be improved. Notably at the driver level, the API is too
closed. I (and/or anyone interested) should find a way to provide more
freedom to drivers developers.

Concerning the library API, I just thought there were too many
functions in comedilib, and some were redundant with each other. I
tried to propose an alternative like the native skin API was an
alternative to the RTAI API. Maybe I was wrong.

All that work relied on my assumption that upstream Comedi was not
very active anymore. Then, it was an opportunity for me to have fun
trying to deliver an RTDM port based on a new architecture.

That was the reason why, I was really suprised to find Comedi
integrated into the mainline kernel. What strikes me more is that
Comedi seems to be left as is. Do you think, it will be cleaned up or
reworked ?

> Another fact I shouldn't have omitted:
>
> * The Xenomai/Comedi layer is very well documented and allows anyone to learn 
> from it, even the upstream maintainers.
> * Seen from my little device driver knowledge, the technical implementation 
> looks ok for synchronous/asynchronous reading and writing. Memory mapped IO is 
> not available, it seems, and the classical comedi_config, inp,outp,... family 
> isn't complete yet either.

I thought comedi_buf_prepare/commit functions were OK to implement
memory mapped IO. Could you explain me what must be added?

For comedi_config, could you tell me what is missing?

>
> I believe Alexis can defend his design better than anyone else, and it's not 
> the design I wanted to tackle. It's how he plans to maintain it.

Once Philippe told me: "one never knows.. a misunderstanding could
make it work" ;)

Seriously, I thought the Xenomai/Comedi could be an interesting
alternative for the original Comedi to keep on providing open source
drivers for data acquisition cards. I understand that the API breakage
is a critical issue which threatens its interest. I will reconsider
the development of a transition layer but last time I thought about
it, I faced so many problems that I gave up.

Many thanks for having a look at the code. I more than welcome any
critics (even flames or anything else). That is, I think, a nice way
to prevent me from making the same mistake many times.

Alexis.

