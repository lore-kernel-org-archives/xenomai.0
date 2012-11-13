Message-ID: <50A224BE.5060800@xenomai.org>
Date: Tue, 13 Nov 2012 11:45:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50A10873.9030907@axelsw.it> <50A109F3.9090106@axelsw.it>
	<50A16CA2.7060403@xenomai.org> <50A1FF6A.3000802@axelsw.it>
In-Reply-To: <50A1FF6A.3000802@axelsw.it>
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

On 11/13/2012 09:06 AM, Roberto Bielli wrote:

> Hi,
> 
> is there a way instead to debug a xenomai userspace application without 
> than the other xenomai task in the application stops  ?


The other xenomai task should not stop when you debug an application,
they only stop when the debugged application is stopped.


-- 
                                                                Gilles.

