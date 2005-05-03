Message-ID: <4277A2A7.8050006@domain.hid>
Date: Tue, 03 May 2005 18:11:19 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <200505030712.j437CaU18874@domain.hid>
In-Reply-To: <200505030712.j437CaU18874@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: Interrupt Latency Question
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Der Herr Hofrat <der.herr@domain.hid>
Cc: Fillod Stephane <stephane.fillod@domain.hid>, rtai@domain.hid, adeos-main@gna.org

On 05/03/2005 09:12 AM Der Herr Hofrat wrote:
>> Hello,
>> 
>> I just run flushy on a low-end PowerPC system:
>> 
>>   XPC855xxZPnnD4 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
>> 
>> Unfortunately the results are not that clear than expected. I see the
>> latency going up a bit but other activities do increase it as well
>> (telnet, ping -f). Furthermore, from run to run the latency results are
> 
> did some measurements on a number of boxes and ping -f is a bad test as
> especially on low end systems it results in the kernel more or less running
> the same code in an infinite loop - resulting in "good" values. If you want
> to see the network layer influence use NetPIPE and see the jitter jump ;)
> 
>> different. Well, I think it's a complex and arch-dependent interplay of
>> various parameters, e.g. on the system above, the caches are quite small
>> and therefore the influence of cache refills is low. When I have more
>> time I might repeat the tests on other PowerPC archs as well.
>> 
>> 
>> Apart from that, you can do little to reduce the latency degradation due
>> to cache refills and TLB misses (at least not in a portable way). Linux
>> simply requires it.
>>
> has anybody ever used gcov feedbacks for ppc ? (run load with kernel compiled
> with -fprofile-arcs recompile -fbranch-probabilities rerun load and test 
> jitter) . The PPC branch prediction should be almost ideal for this and that
> would be a fairly portable way of doing it.

I never tried that but I doubt that it will reduce cache refills and TLB
misses. I will have a closer look when time permits.

Wolfgang.


