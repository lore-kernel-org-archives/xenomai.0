Message-ID: <45E5ED29.8070505@domain.hid>
Date: Wed, 28 Feb 2007 21:59:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN rt_dev_recvfrom
References: <bc4264770702281208u7d7ee013qa5be819a5856d4ea@domain.hid>
In-Reply-To: <bc4264770702281208u7d7ee013qa5be819a5856d4ea@domain.hid>
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
> 
> Ok the issue I posted earlier regarding the read function. It seems
> that it IS recieving can messages and displaying them correctly. Only
> its behaviour is not as I expected. I thought the function
> 
> rt_dev_recvfrom
> 
> would simply perform a read one frame from a buffer (which in my
> experience holds a number of can messages) then exit.
> 
> By the look of things I will have to implement the aforementioned
> buffer myself. I.e
> 
> run rt_dev_recvfrom in a separate thread other than my periodic task
> and store an x number of messages in BUFFER that I recieve there. The
> can_read() function which I implement in the periodic task must then
> simply read the messages from BUFFER.
> 
> Can this be confirmed or is rt_dev_recvfrom() behaving incorrectly in my 
> case?

rt_dev_recvfrom() reads message frames (one at a time) from an internal 
socket buffer (there is actually a kernel configuration option to 
configure the size). If no messages are available, it will block by 
default, but it can also be used in non-blocking mode by using the flag 
MSG_DONTWAIT. It seems, that your application is trying to read messages 
periodically in polling mode. Either you do reading and buffering in 
your own thread as you suggested above or you use rt_dev_recvfrom() in 
non-blocking mode.

Wolfgang.


