Message-ID: <BLU436-SMTP24288FFE3F009CFBD2CADE8F0130@phx.gbl>
References: <BLU437-SMTP3567D7D9516D88AF50AA67F0130@phx.gbl>
 <20151111161234.GA1820@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Wed, 11 Nov 2015 13:14:06 -0800
MIME-Version: 1.0
In-Reply-To: <20151111161234.GA1820@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency test on RP2 vs Odroid-C1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-11 08:12 AM, Gilles Chanteperdrix wrote:
> On Wed, Nov 11, 2015 at 07:40:03AM -0800, Mathieu Rondonneau wrote:
>> Hi,
>>
>> I finally was able to run the latency test on RPI2.
>>
>> the results are showing: lat best of 7.705 and worst 16.605
>> with an average of 9.129
>
> I do not know whether you ran the latency test under load, but that
> is the only way to get meaningful results (i.e. approaching the
> worst case latency). In order to run the latency test under load, we
> use the xeno-test script, with the LTP testsuite.
>
Thanks for your suggestion Gilles,
it was not under load for sure.

I tried the xeno-test and cyclictest.
no LTP yet.

I am not sure how does it compare with other boards (beaglebone, odroid 
...) yet.

-Mathieu



