Message-ID: <54905ABD.20304@telecom-paristech.fr>
Date: Tue, 16 Dec 2014 17:15:57 +0100
From: Renaud Pacalet <renaud.pacalet@telecom-paristech.fr>
MIME-Version: 1.0
References: <548F07F1.7010606@telecom-paristech.fr>
 <20141215161839.GO11058@hermes.click-hack.org>
 <548FDC78.5080600@telecom-paristech.fr>
 <20141216111634.GR11058@hermes.click-hack.org>
In-Reply-To: <20141216111634.GR11058@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] I-pipe patch broken for Xilinx Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 12/16/14 12:16, Gilles Chanteperdrix wrote:
> On Tue, Dec 16, 2014 at 08:17:12AM +0100, pacalet wrote:
>> Would you like me to post the rejects files somewhere?
> 
> No. The problem is that the ipipe-core-3.8.13-arm-4.patch (and not 
> -3, as I said, you should be using the latest version), as its
> name indicates, is made for Linux 3.8.13, whereas the xilinx tag is
> based on 3.8.0. So, the correct procedure is:
> 
> git checkout -b xenomai-test 6a0bedad git remote add stable
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>
> 
git fetch stable
> git merge v3.8.13 patch -p1 <
> /path/to/ipipe-core-3.8-zynq-pre.patch patch -p1 <
> /path/to/ipipe-core-3.8.13-arm-4.patch patch -p1 <
> /path/to/ipipe-core-3.8-zynq-post.patch

Thanks a lot Gilles, I got it now. And it worked like a charm.

Best regards,
- -- 
Télécom ParisTech - LabSoC
c/o EURECOM, Campus SophiaTech
Les Templiers, 450 route des Chappes 06410 Biot
Tel : +33 (0) 4 9300 8402
Fax : +33 (0) 4 9300 8200
Web : http://www.telecom-paristech.fr/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEAREIAAYFAlSQWrwACgkQ6X2qPZD76M9BBwCfe3Ji/koRBA+U1pUSZlmLFAe+
1l8AoIbKkVwRke+UWSXcc6mrpIu8R/Oa
=qrzR
-----END PGP SIGNATURE-----

