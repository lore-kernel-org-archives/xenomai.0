Message-ID: <53FAF3A6.6020500@xenomai.org>
Date: Mon, 25 Aug 2014 10:28:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140822213159.GQ17765@csclub.uwaterloo.ca>
 <53F7B7E1.80009@xenomai.org> <53F7BC3B.1080800@xenomai.org>
 <20140825022930.GS17765@csclub.uwaterloo.ca>
In-Reply-To: <20140825022930.GS17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Any idea how to fix ipipe failing to compile with ARM
 LPAE enabled?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 08/25/2014 04:29 AM, Lennart Sorensen wrote:
>> No, I do not think that LPAE uses exceptions. You can try moving the
>> #endif at the bottom of the file to above the #ifdef CONFIG_IPIPE.
> 
> I did try that, and it did compile.  Never did boot, although I think I
> may need to enable hypervisor mode in the boot loader before it will boot.
> I will experiment some more.

Does the kernel configured without LPAE boot?

-- 
                                                                Gilles.

