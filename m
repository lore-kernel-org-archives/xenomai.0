References: <583D46A3.7010206@numalliance.com> <58403FE3.50701@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ad43843-4bb0-c1ab-1233-04674abd3365@xenomai.org>
Date: Sat, 3 Dec 2016 18:16:07 +0100
MIME-Version: 1.0
In-Reply-To: <58403FE3.50701@numalliance.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: rt,Heap segfault with unittest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benjamin ROUZAUD <brouzaud@numalliance.com>, xenomai@xenomai.org

On 12/01/2016 04:21 PM, Benjamin ROUZAUD wrote:

> the process C tries to create or link differents allocation areas but it
> crashes with segfault after many
> creation.
> 

Then you may want to run your test application over GDB, and inspect the
stack backtrace for locating the offending code. You could also build it
for Mercury in debug mode (--enable-debug=full) instead of Cobalt, and
use Valgrind to detect memory errors.

-- 
Philippe.

