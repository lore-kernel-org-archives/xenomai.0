Message-ID: <4E3BE7B7.3040505@domain.hid>
Date: Fri, 05 Aug 2011 14:53:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1312486056.62780.YahooMailClassic@domain.hid>
In-Reply-To: <1312486056.62780.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: Xenomai-help@domain.hid

On 08/04/2011 09:27 PM, Philip Ha wrote:
>> Would it be possible for you to send mails formatted correctly?
>>
>> Then the bug is somewhere in between the serial line and the test
>> application, including possibly in the driver.
>>
>> In order to know where it is, you should compute the latency at each
>> point on this path: when receiving the interrupt, when waking up the
>> task, etc...
>
> Hi Gilles,
> 
> Sorry for the formatting, I am new to mailing lists.
> 
> I have looked at the latency in the 16550A driver. The first thing 
> the driver does in its ISR is to call rtdm_clock_read and store the 
> resulting timestamp in a "struct rtser_event". The code I posted 
> grabs this structure. If I use this as my timestamp I get the exact
> same timing results.

are you sure that the interrupt triggers as soon as you receive a
character, and not upon timeout when not receiving characters for some
time? After all, 100us is approximately the time to transmit one
character at 115200 bauds on the serial line.

-- 
					    Gilles.

