References: <CAHN8pEZByi0QXdxwrDhdFshF-uyHoXYGc3z=vAdLGC=BwNmYxQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b3e6c123-9cef-8570-7040-aa6bd0575090@xenomai.org>
Date: Sun, 12 Mar 2017 18:13:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAHN8pEZByi0QXdxwrDhdFshF-uyHoXYGc3z=vAdLGC=BwNmYxQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raw Ethernet socket in Xenomai 3.0.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ed Hannigan <edphannigan@gmail.com>, xenomai@xenomai.org

On 03/11/2017 08:58 PM, Ed Hannigan wrote:
> I have a Xenomai 2.6.1 userspace app that uses RTNet 0.9.13 and I can
> send/receive raw Ethernet packets with calls rt_dev_send and rt_dev_recv.
> 
> I am trying to migrate to Xenomai 3.0.3 but receiving a negative error
> code from the following line:
> 
> s = rt_dev_socket(AF_PACKET, SOCK_RAW, MY_PROTOCOL);
> 
> rtifconfig shows rteth0 as UP and receives packets so my
> 8139 works.  The eth_p_all demo appears to only show packets received
> from non-realtime cards.  Looking on the web I've seen that maybe I should
> use rtdm_socket, rtdm_send, etc

No, these services belong to the inter-driver RTDM API in kernel space:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Inter-Driver_API

.  If I try doing this then I run into linker
> errors with the Cobalt core.  I need help with setup and sending/receiving
> of raw Ethernet packets from in user-space.

You can either:

- convert your code from the legacy rt_dev_* API in user-space to the
regular socket API (preferred option), which requires to enable symbol
wrapping, so that socket/sendmsg/recvmsg/... are pulled from libcobalt
instead of libc. See
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Under_the_hood_the_8211wrap_flag
http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

- enable the compatibility mode for building your app, by passing the
"--rtdm --compat" switches to xeno-config when retrieving the CFLAGS or
LDFLAGS (xeno-config --cflags/--ldflags ...).

-- 
Philippe.

