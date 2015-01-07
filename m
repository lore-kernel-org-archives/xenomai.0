Message-ID: <54ACFFD3.6090107@siemens.com>
Date: Wed, 07 Jan 2015 10:43:47 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1Y89RI-000705-G1@sd-51317.xenomai.org>
 <20150106100352.GB11206@hermes.click-hack.org>
In-Reply-To: <20150106100352.GB11206@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : sysregd: Unmount
	filesystems via fusermount
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On 2015-01-06 11:03, Gilles Chanteperdrix wrote:
> On Mon, Jan 05, 2015 at 04:19:28PM +0100, git repository hosting wrote:
>> +static void unmount(const char *path)
>> +{
>> +	const char cmd_tmpl[] = "/usr/bin/fusermount -uzq ";
>> +	char *cmd = malloc(sizeof(cmd_tmpl) + strlen(path));
>> +
>> +	if (cmd) {
>> +		strcpy(cmd, cmd_tmpl);
>> +		strcat(cmd, path);
>> +		system(cmd);
>> +		free(cmd);
>> +	}
>> +}
> 
> That is really ugly. Why not using asprintf ?

Good point. Wasn't fully aware of this function.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

