Message-ID: <434B7928.1080201@domain.hid>
Date: Tue, 11 Oct 2005 11:34:48 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Generated docs
References: <434B6BC6.4030401@domain.hid>	<17227.27763.201941.114412@domain.hid>	<434B6FA4.80309@domain.hid>	<17227.29206.223750.761504@domain.hid>	<434B7422.6040603@domain.hid>
	<17227.30216.496851.780843@domain.hid>
In-Reply-To: <17227.30216.496851.780843@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix kirjoitti:
> Heikki Lindholm wrote:
>  > Gilles Chanteperdrix kirjoitti:
>  > Indeed. But this is the special attention I'm talking about ;) I'm still 
>  > not convinced about the "need 'em for the release" reasoning. Let's put 
>  > it this way: what trouble would it bring, if we had "dist" always 
>  > generate docs for a release (and not have them in the repo)?
> 
> Allows to share the load during releases: I generate the doc, using the
> "generate-doc" target in the doc directory, run svn commit to put them
> in the repository. Then Philippe runs svn update and make dist. As I
> said, it allows to have a separate maintenance of documentation and
> sources.

Hehe. So Philippe's machine would choke, if it had to generate the docs, 
too(?) And since most(?) of the docs comes from the sources, you don't 
actually edit them by hand now do you? So what does maintaining mean here?

> Having the generated documentation in svn repository also allows us to
> copy it to the documentation directory of the download zone from a
> script run by cron.

Ok, this makes sense. But could be done by other means, too, I guess.

-- Heikki Lindholm

