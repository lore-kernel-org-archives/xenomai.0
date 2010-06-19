Message-ID: <4C1CD0FB.90304@domain.hid>
Date: Sat, 19 Jun 2010 16:15:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C163AB5.3020903@domain.hid>
In-Reply-To: <4C163AB5.3020903@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] debian: fix init script start/stop values
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi,
> 
> the attached patch fixes the following installation warning on debian squeeze and ubuntu lucid:
> update-rc.d: warning: xenomai start runlevel arguments (2 3 4 5) do not match LSB Default-Start values (S)
> update-rc.d: warning: xenomai stop runlevel arguments (0 1 6) do not match LSB Default-Stop values (none)

Merged, thanks.

-- 
					    Gilles.

