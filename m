Message-ID: <4509A998.4000102@domain.hid>
Date: Thu, 14 Sep 2006 14:12:24 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] read returns more bytes than requested?
References: <4505E719.3030405@domain.hid> <1158239386.5040.105.camel@domain.hid>
In-Reply-To: <1158239386.5040.105.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Mon, 2006-09-11 at 17:45 -0500, Jeff Webb wrote:
>> I didn't think that a read could return more bytes than was requested. 
>> Does anyone understand this behaviour?  This is code that works under RT-Linux.
>> I am trying to determine why it is working differently under xenomai.
> 
> Another round of refactoring the message pipe support. This time, it
> introduces the ability to get partial reads from the /dev/rtp* device
> endpoint, instead of requiring read() calls to collect all of the
> pending data at once. The remaining work will allow the same from the
> real-time API endpoint. This patch applies against the latest patch
> sent.

Thanks again!  The read appears to be working now, at least as far as I can tell.  I am now hunting down the source of an unrelated bug, a little further down the line.

-Jeff


