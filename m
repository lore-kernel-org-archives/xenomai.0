Message-ID: <51A5044C.1030109@xenomai.org>
Date: Tue, 28 May 2013 21:23:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51A4A22D.2090308@siemens.com>
In-Reply-To: <51A4A22D.2090308@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] compiler error due to __extension__ attribute in
 POSIX skin headers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 05/28/2013 02:25 PM, Gernot Hillier wrote:

> Hi there!
> 
> The recent commit "posix: allow headers compilation with GCC pedantic 
> flag" added the "__extension__" attribute in front of #include_next 
> directives, likely to flag them as GNU extensions. This, however, 
> introduced compiler errors for us when we include those headers from C++ 
> code.


Hi Gernot,

thanks for the detailed report. The "__extension__" trick worked with
the version of gcc I use, but if the pragma trick works better with
later compiler, I will use it. Will fix, thanks.

Regards.

-- 
                                                                Gilles.

