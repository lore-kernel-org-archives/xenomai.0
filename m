Message-ID: <42D43C63.2010706@domain.hid>
Date: Tue, 12 Jul 2005 23:55:47 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: [Adeos-main] LRTBF par-log.c &
	adeos_critical_enter	question]
References: <42D2B3B7.30007@domain.hid> <1121117338.6162.38.camel@domain.hid>
In-Reply-To: <1121117338.6162.38.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Kristian Benoit <kbenoit@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Hi Kristian!

Thanks a lot for your reply!

Kristian Benoit wrote:
> On Mon, 2005-07-11 at 20:00 +0200, Hannes Mayer wrote:
> 
>>Dear Kristian!
>>
>>Philippe (Gerum) just notified me, that you're probably not subscribed
>>to the Adeos-Main maillist, so I'm forwarding my mail to the list.
>>I hope that is OK.
> 
> Now I am :) thanks.
> 
>>After adeos_critical_enter, interrupts are disabled anyway (right?), so no
>>modification of read_pos or write_pos is possible and reading over the
>>proc file is not disturbed.
>>
>>Furthermore in read_proc you reset disable_timer only after the complete
>>buffer was read via the proc file:
>>
>>	if (read_pos == write_pos) {
>>		disable_timer = 0;
> 
> 
> Exactly, that's the reason.

So you disable writing to the buffer by design and not because it would interfer
with read_proc.

>>The problem:
>>While some user-space app is reading from the proc file, nothing is written
>>to the buffer and this causes data loss.
> 
> 
> As it actually is only used by lrtbf in the way I wrote it, it does not
> really matters. And in that particular case it is better like that as I
> insert the module. Do some job on the target. Then when the job is done,
> I start reading from the proc file and dont get post job interrupt data
> in the buffer.
> 
> 
>>IMO, it would be best, if writing to the buffer is not disabled in read_proc.
>>In the actual data copying action in read_proc/while-loop no interrupt can
>>interfer - and if not everything from the buffer was read in the first place,
>>there is no problem if some data is added to the buffer until the next read
>>action occurs.
> 
> 
> I must admit that it is not really made to be read more than once. I
> thought of doiing a double buffering method, but I did'nt much time to
> implement an unnecessary feature. (unnecessary in the actual state)   

Yeah, I was already too much focused on my application - in your app that
problem is not critical.

I've done some tests and I'm able to have an interrupt frequency of up to
more than 40kHz, writing data to the buffer, reading via an userspace app
and writing to disk without losing data on my P3/450MHz box.
(the traditional way, not with relayfs - will look into that soon)

I just have a followup to one of my orignal questions (maybe for Philippe):
After adeos_critical_enter, all interrupts are disabled and are enabled
again with adeos_critical_exit.
The interrupts occuring during this time are not cached somewhere, aren't they ?
I mean, is it possible to get information on how many interrupts were lost ?

Thanks & best regards,
Hannes.

