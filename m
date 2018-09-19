MIME-Version: 1.0
References: <4a23fc70.13419.165f2042151.Coremail.lordopt@163.com>
In-Reply-To: <4a23fc70.13419.165f2042151.Coremail.lordopt@163.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 19 Sep 2018 10:38:29 -0400
Message-ID: <CALLqZ8TrXK8F_1YX1+wAzuC2sk0miXNZr-s_EZiBYTm-nzbDsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Missing header file of RTDM driver programming
 interface (xenomai-v3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: lordopt@163.com
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Did you run the prepare-kernel script?  The header should be in the linux
tree you are build the kernel from in
<path_to_kernel>/include/xenomai/rtdm/driver.h

-Greg

On Wed, Sep 19, 2018 at 9:28 AM =E5=88=98=E5=BB=BA=E5=BA=B7 <lordopt@163.co=
m> wrote:

> Hi everyone,
>
> I am trying to compile Igh EtherCAT master (
> http://www.etherlab.org/en/ethercat/) under xenomai3 (v3.0.7).
> The Igh-EtherCAT master is developed using xenomai2 RTDM interface,
> according to the migrating instructions:
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Migrating_From_Xenomai_2_To_=
3
> The header file "rtdm/rtdm_driver.h" is renamed to "rtdm/driver.h".
> However, "driver.h" is not found in the installation path
> "/usr/xenomai/include/rtdm/"
>
> Why "driver.h" is not installed? Which header file should be included
> instead of "#include <rtdm/rtdm_driver.h>"?
>
> Thanks,
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
