References: <E1aXuTj-0000rZ-UQ@sd-51317.xenomai.org>
 <20160222174421.GD7398@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56CB4BE5.3090702@siemens.com>
Date: Mon, 22 Feb 2016 18:56:53 +0100
MIME-Version: 1.0
In-Reply-To: <20160222174421.GD7398@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : boilerplate: Allow for
 enabling Xenomai only in shared libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

[please CC me on replies, I've delivery turned off for all lists]

On 2016-02-22 18:44, Gilles Chanteperdrix wrote:
> On Mon, Feb 22, 2016 at 06:40:59PM +0100, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: 4601286f7fedb8267ea314584fc68d2b35b818a4
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=4601286f7fedb8267ea314584fc68d2b35b818a4
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Fri Feb  5 17:33:18 2016 +0100
>>
>> boilerplate: Allow for enabling Xenomai only in shared libs
>>
>> Normally, one builds shared libraries with Xenomai awareness by adding
>> --no-auto-init to xeno-config. This drops bootstrap.o from the linking
>> steps because - normally - the main application performs the
>> initialization.
>>
>> However, if the main application is Xenomai-free and only dlopen() would
>> pull in Xenomai services via a shared library, we face two problems:
>>
>> - bootstrap.o is not built with position-independence support
>>
>> - libboilerplate contains __real_main that expects the main symbol which
>>   cannot be found from a shared library
> 
> Does not the library find the program symbols if RTLD_GLOBAL is
> passed to dlopen?

Nope, just retried, didn't help. In fact, RTLD_GLOBAL affects only the
opened library's symbols, not the pre-existing ones. I think it is
simply not possible with dlopen to refer back to a symbol from the code
that loads the library.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

