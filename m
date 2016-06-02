References: <DB5PR06MB1287D4090873A5C9EC9B540A8F720@DB5PR06MB1287.eurprd06.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <063cc054-45bf-97a8-c036-6a06993bf415@xenomai.org>
Date: Thu, 2 Jun 2016 15:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <DB5PR06MB1287D4090873A5C9EC9B540A8F720@DB5PR06MB1287.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XDDP NRT to RT communication and select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Plits <alex_plits@radwin.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/11/2016 08:58 AM, Alex Plits wrote:
> Hi,
> 
> We require communication between non-real time and real time thread in xenomai 3.x, so naturally we planned to use
> XDDP.
> After careful read and looking into examples in smokey we tried to implement simple communication
> Between NRT thread that sends via RTP pseudo device a buffer to RT thread which is blocked on xenomai "select" (read_fds)
> based on a ripped example of XDDP in smokey (without 2nd real time thread),
> i.e. NRT thread periodically sends messages to the RT thread waiting on select before actual receive call.
> Unfortunately the "select" call on the RT thread was never triggered - although in the smokey unit test it worked as expected,
> the only difference was the 2nd real time thread (which we got rid of in our case) used "sendto" call to that XDDP socket.
> After some xenomai code examination we saw that XDDP send/recv functions do signal xenomai select waiters which explains the smokey case (sendto triggered select) but
> It seems (correct me if I'm wrong) that xnpipe_write/read do not.
> In order to confirm that we used "xnselect_signal" to trigger the xenomai select waiters in the "__xddp_input_handler" callback that is called inside xnpipe_write and this seemed to work.
> So my queries are -
> 
> 1.       Does XDDP mechanism support select call for NRT writers  - or did we misread https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#IO_multiplexing_with_select?
> 

That was the plan, but as you noticed, the implementation was broken,
spuriously connecting the rt output to the rt input instead.

> 2.       Will the opposite direction work i.e. RT-> NRT that is waiting on a select?
> 

Yes, this is a separate code path, which works fine.

> 3.       Is the small patch we added acceptable for the case described above / is there any additional locking that we need to handle?
> 

I don't know the exact implementation of your fix, but this should
indeed live in the pipe input handler from the XDDP protocol module.
Conversely, the corresponding code has to be removed from __xddp_sendmsg().

http://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=fd828bf38f2c7ba5140cbbf1ae932a5e184f823f

-- 
Philippe.

