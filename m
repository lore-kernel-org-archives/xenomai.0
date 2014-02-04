Message-ID: <52F130E6.6050504@xenomai.org>
Date: Tue, 04 Feb 2014 19:26:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com> <52F12F68.9040605@siemens.com>
In-Reply-To: <52F12F68.9040605@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai-git@xenomai.org, xenomai@xenomai.org

On 02/04/2014 07:20 PM, Jan Kiszka wrote:
> On 2014-02-04 19:03, Jan Kiszka wrote:
>> BTW, there are way more issues with C++ when enabling standard
>> compliance. Not sure where all the errors come from and if they easy to
>> fixing. But I think we should try to be as clean as possible in out
>> external interfaces.
>
> GCC-only typeof is our problem. Simply doing

What about __typeof__ ?


-- 
					    Gilles.

