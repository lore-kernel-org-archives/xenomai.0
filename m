MIME-Version: 1.0
In-Reply-To: <20150428083243.GB1993@hermes.click-hack.org>
References: <CAKC9m6eKP5fvSx7ximsehOYKxZhm15EFaWeRhqUcUozWM-pjLw@mail.gmail.com>
 <20150428082434.GA1993@hermes.click-hack.org>
 <20150428083243.GB1993@hermes.click-hack.org>
Date: Tue, 28 Apr 2015 22:58:23 -0700
Message-ID: <CAKC9m6dfDfp3g0v4seKpzem4KKWbApFsu7Ttd3N_AVbiCsEsnw@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Porting the I-pipe core to ARM big.LITTLE architecture
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thank you, Gilles, for the helpful info and the suggestion to work
around the inherent CPU power management scheme.

Hongfei

On Tue, Apr 28, 2015 at 1:32 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Tue, Apr 28, 2015 at 10:24:34AM +0200, Gilles Chanteperdrix wrote:
>> On Tue, Apr 28, 2015 at 01:08:12AM -0700, Hongfei Cheng wrote:
>> > Searching the mailing list archives, I don't see mentioning of ARM's
>> > big.LITTLE architecture. The list of the supported SoCs doesn't appear
>> > to include any SoC based on ARM's big.LITTLE architecture.
>> >
>> > Are there any special considerations for porting the I-pipe core to
>> > such big.LITTLE architecture?
>>
>> I would say this sounds like cpufreq:
>> - migrating a task from an A15 to an A7 will have a huge impact on
>> latencies
>> - the speed difference will have a huge impact on the timings of the
>> running tasks.
>
> Note that xenomai never migrates a task from a cpu to another
> automatically for the same reason.
>
> --
>                                             Gilles.

