Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <2247681.JhopzYo4NN@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BBF2@DDCEXCH.ddc-ny.com>
 <7041379.eS1cmEbPlD@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com>
Date: Wed, 31 Oct 2018 19:18:53 +0100
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: "Hillman, Robert" <hillman@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 31.10.18 17:55, Pham, Phong wrote:
> 
> Hi Sebastian,
> 
> The issue has to do with endianness.  We are running PowerPC (big endian).  So in rt_tcp_set_flags(), flags is 32-bit wide and *tf is 16-bit wide.  I modified the line
> from:
> 
> *tf = flags;
> 
> to
> 
> *tf = *(__be16 *)&flags;

Something is fishy with rt_tcp_set_flags. Shouldn't we rather ensure that only a 
__be16 flag value is passed to it?

> 
> and that does the job.
> 
> Now I encounter a different problem,
> 
> recv() returns 0 bytes but I know my FTP server sends a packet (seen by WireShark).  Can you point me where is the recv() implemented in tcp.c?  Is it rt_tcp_rcv or rt_tcp_recvmsg?

The incoming packet is forwarded to rt_tcp_rcv. rt_tcp_recvmsg is called when an 
application does some recvmsg-like call.


You are probably the first one to try the tcp implementation on big endian. IOW: 
There might be more endianness issues ahead.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

