COPY (SELECT	(siren || nic)::text AS "SIRET",
		l1_normalisee AS "L1_NOMEN",
		l2_normalisee AS "L2_COMP",
		l3_normalisee AS "L3_CADR",
		l4_normalisee AS "L4_VOIE",
		l5_normalisee AS "L5_DISP",
		l6_normalisee AS "L6_POST",
		l7_normalisee AS "DEPET",
		rpet AS "L7_ETRG",
		depet AS "RPET",
		arronet AS "ARRONET",
		ctonet AS "CTONET",
		comet AS "COMET",
		libcom AS "LIBCOM",
		du AS "DU",
		epci AS "EPCI",
		tu AS "TU",
		uu AS "UU",
		null::text AS "CODEVOIE",
		tcd AS "TCD",
		zemet AS "ZEMET",	
		numvoie AS "NUMVOIE",
		indrep AS "INDREP",
		typvoie AS "TYPVOIE",
		libvoie AS "LIBVOIE",
		codpos AS "CODPOS",
		cedex AS "CEDEX",
		null::text AS "ZR1",
		siege AS "SIEGE",
		enseigne AS "ENSEIGNE",
		null::text AS "NOM_COM",
		natetab AS "NATETAB",
		libnatetab AS "LIBNATETAB",
		apet700 AS "APET700",
		libapet AS "LIBAPET",
		dapet AS "DAPET",
		tefet AS "TEFET",
		efetcent AS "EFETCENT",
		dcret AS "DCRET",
		defet AS "DEFET",
		origine AS "ORIGINE",
		amintret AS "AMINTRET",
		activnat AS "ACTIVNAT",
		lieuact AS "LIEUACT",
		actisurf AS "ACTISURF",
		saisonat AS "SAISONAT",
		modet AS "MODET",
		auxilt AS "AUXILT",
		prodet AS "PRODET",
		prodpart AS "PRODPART",
		null::text AS "ZR2",
		nomen_long AS "NOMEN_LONG",
		sigle AS "SIGLE",
		civilite AS "CIVILITE",
		nj AS "NJ",
		libnj AS "LIBNJ",
		apen700 AS "APEN700",
		libapen AS "LIBAPEN",
		dapen AS "DAPEN",
		aprm AS "APRM",
		tefen AS "TEFEN",
		efencent AS "EFENCENT",
		defen AS "DEFEN",
		categorie AS "CATEGORIE",
		dcren AS "DCREN",
		amintren AS "AMINTREN",
		monoact AS "MONOACT",
		moden AS "MODEN",
		proden AS "PRODEN",
		esaann AS "ESAANN",
		tca AS "TCA",
		esaapen AS "ESAAPEN",
		esasec1n AS "ESASEC1N",
		esasec2n AS "ESASEC2N",
		esasec3n AS "ESASEC3N",
		esasec4n AS "ESASEC4N",
		null::text AS "REGIMP",
		null::text AS "MONOREG",
		null::text AS "ZR3",
		rpen AS "RPEN",
		depet || comet AS "DEPCOMEN",
		vmaj AS "VMAJ",
		vmaj1 AS "VMAJ1",
		ind_publipo AS "IND_PUBLIPO",
		vmaj2 AS "VMAJ2",
		vmaj3 AS "VMAJ3",
		to_char(CURRENT_DATE, 'DD/MM/YYYY') AS "MAJ_DATE"
	  FROM :table
	)
  TO :output_csvfile WITH (format csv, header true, delimiter ';', encoding 'UTF-8');