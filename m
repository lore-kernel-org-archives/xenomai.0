Message-ID: <52DBA3E0.1050706@xenomai.org>
Date: Sun, 19 Jan 2014 11:07:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52D919F7.8020908@siemens.com>
In-Reply-To: <52D919F7.8020908@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge: make install fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/17/2014 12:54 PM, Jan Kiszka wrote:
> Hi Philippe,
>
> I guess there is a generated file missing in git:
>
> make[3]: Entering directory `/data/xenomai-forge/build64/doc/asciidoc'
> make[3]: Nothing to be done for `install-exec-am'.
> make[3]: *** No rule to make target `../../../doc/asciidoc/../generated/html/MIGRATION', needed by `install-htmldocs'.  Stop.
>

Yep, bootstrapping "generate-doc" was required.
Thanks for the heads up.

-- 
Philippe.

