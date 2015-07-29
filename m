References: <55B8A722.5070405@xenomai.org>
 <279611839.4860606.1438170528832.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B8C70A.9010107@xenomai.org>
Date: Wed, 29 Jul 2015 14:28:58 +0200
MIME-Version: 1.0
In-Reply-To: <279611839.4860606.1438170528832.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/29/2015 01:48 PM, Frederik Bayart wrote:

> In attachment my latest version of stest.c to be sure, there are only small modifications.
>

If __XENO_COMPAT__ is enabled, that should mean that you built your
application with --[skin=]native, which automatically enables backward
compat mode from {lib, include}/trank, to the new alchemy API.

In this case, you don't need to test this symbol for picking the proper
include files, these are available from include/trank/native, which
xeno-config points you at.

Obsolete definitions like T_FPU will be found in those compat headers.

-- 
Philippe.

