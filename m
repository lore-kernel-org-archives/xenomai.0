Date: Tue, 6 Jan 2015 11:03:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150106100352.GB11206@hermes.click-hack.org>
References: <E1Y89RI-000705-G1@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Y89RI-000705-G1@sd-51317.xenomai.org>
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
To: xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On Mon, Jan 05, 2015 at 04:19:28PM +0100, git repository hosting wrote:
> +static void unmount(const char *path)
> +{
> +	const char cmd_tmpl[] = "/usr/bin/fusermount -uzq ";
> +	char *cmd = malloc(sizeof(cmd_tmpl) + strlen(path));
> +
> +	if (cmd) {
> +		strcpy(cmd, cmd_tmpl);
> +		strcat(cmd, path);
> +		system(cmd);
> +		free(cmd);
> +	}
> +}

That is really ugly. Why not using asprintf ?

-- 
					    Gilles.

