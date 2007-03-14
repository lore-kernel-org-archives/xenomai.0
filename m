Message-ID: <45F7D59E.3090406@domain.hid>
Date: Wed, 14 Mar 2007 11:59:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] debian/rules update
References: <200703121756.08070.paul_c@domain.hid>	<1173803432.16997.71.camel@domain.hid>	<200703132032.26296.paul_c@domain.hid>
	<1173869781.32259.29.camel@domain.hid>
In-Reply-To: <1173869781.32259.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2007-03-13 at 20:32 +0000, Paul wrote:
> 
>>Hi Philippe
>>
>>On Tuesday 13 March 2007 16:30, Philippe Gerum wrote:
>>
>>>>A question for the project admins: Do you have a Release Manager to
>>>>coordinate package releases ?
>>>
>>>I'm currently coordinating the Xenomai releases, with input from the
>>>sub-systems/architecture maintainers. I guess that by "package", you are
>>>referring to another division of the work, though.
>>
>>By "package", I mean binaries in the form of *.deb and/or *.rpm - Whilst I'm 
>>happy to build and host i386/x86 Debian packages, I'm concerned about 
>>treading on someone's toes without a discussion about revision numbers and 
>>general policy about "official" releases.
> 
> 
> So far, we don't have an established policy for making distro-oriented
> packages; a few people have contributed some of them from time to time,
> but there is no "appointed" maintainer doing sustained work for the
> project on this issue yet.
> 
> 
>> For example, the packages I've 
>>built to date have used 2.3.50 even although a tarball of that version hasn't 
>>been released.. That could well cause confusion for users and yourself if 
>>bugs are reported. There is also a minor problem with keeping the 
>>debian/changelog in sync.
>>
>> One possible answer is for me to rebuild my repository from scratch and 
>>append the SVN revision number to revision number so that we end up with 
>>2.3.50-1~r2289 - This would allow an official 2.3.50-1 release to override 
>>the ~r2289 revision..
>>
> 
> 
> It would be saner to use the commit number indeed, especially since it
> allows decouple the package versioning from the source releases while
> keeping a reference to a common history of changes.

Do we really want to make debian packages with trunk ? Would not it make
sense to only make debian packages from stable releases ?

-- 
                                                 Gilles Chanteperdrix

