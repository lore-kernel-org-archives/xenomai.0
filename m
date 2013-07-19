Message-ID: <51E900B7.9070604@xenomai.org>
Date: Fri, 19 Jul 2013 11:02:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
In-Reply-To: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __xn_sys_current_info failed: Operation not permitted
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/18/2013 12:24 PM, Franz Engel wrote:
> Hi,
>
> I get this error when I run a programm:
> __xn_sys_current_info failed: Operation not permitted
>
> I know that the error comes from the assert_nrt_inner(void) function inside the assert_context.c file. But I have no idea what is the reason. The Operation not permitted is the return value from XENOMAI_SYSCALL1(__xn_sys_current_info, &info);. But I found no documentation about this function.
>

This is reminiscent of a symptom observed for a bug fixed in the -forge 
tree, a while ago: 
http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=014898add6a697e1a0d69f9e20b910ade74f1940

Do you happen to call fork() in your application?

-- 
Philippe.

