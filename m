Message-ID: <50A24098.60102@xenomai.org>
Date: Tue, 13 Nov 2012 13:44:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50A10873.9030907@axelsw.it> <50A109F3.9090106@axelsw.it>
	<50A16CA2.7060403@xenomai.org> <50A1FF6A.3000802@axelsw.it>
	<50A224BE.5060800@xenomai.org> <50A23D62.3080409@axelsw.it>
In-Reply-To: <50A23D62.3080409@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debug a xenomai application with gdb stops another
 xenomai application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: xenomai@xenomai.org

On 11/13/2012 01:30 PM, Roberto Bielli wrote:

> Hi Gilles,
> 
> excuse me for my english but the exact question is this:
> 
> i have two applications with xenomai tasks.
> 
> I want to debug the first application with gdb but i don't want to debug 
> the second.
> I want that the second goes normally.
> 
> Tha actual behaviour is that if i put a breakpoint in a xenomai task in 
> the first application also the tasks in the second applications stops.


If that happens then this is a bug. The second application should only
stop when you hit the breakpoint or otherwise stop the first application
in the debugger, not when you PUT the breakpoint.

> 
> You answer me that it's the correct behavior because it's a feature.
> 
> So i ask you if there is a way to allow to debug the first application 
> without the second stops.


No.

-- 
                                                                Gilles.

