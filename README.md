# these-I3S

Vous trouverez ici un modèle de thèse en latex avec pour [couverture celle demandée par Université Côte d'Azur](https://bu.univ-cotedazur.fr/fr/utiliser-nos-services/deposer-sa-these-ou-son-memoire/deposer-sa-these-de-doctorat).

Les macros `\hdr` et `\master` permettent de spécifier que le document est respectivement pour une habilitation à diriger les recherches et pour une mémoire de master.

Une pipeline GitHub Actions compile automatiquement le projet à chaque nouveau commit. Ainsi, vous avez la garantie que le code LaTeX compile correctement à chacune de vos modifications, si le job réussit !

Une fois le job terminé, vous pourrez alors télécharger le PDF compilé directement dans les artefacts GitHub:

Aller dans l'onglet **Actions**:

![onglet Github Actions](assets/github_actions_tab.png)

Sélectionner le dernier Workflow, correspondant à votre commit:

![Workflow GitHub actions](assets/build_workflow.png)

Enfin, télécharger votre fichier PDF compilé:

![Téléchargement de l'artefact compilé](assets/download_artifact.png)

N'hésitez pas à poster des issues ou faire des pull-request pour améliorer ce modèle.

---

You'll find here a Ph.D. thesis template in latex with the [first page requested by Université Côte d'Azur](https://bu.univ-cotedazur.fr/fr/utiliser-nos-services/deposer-sa-these-ou-son-memoire/deposer-sa-these-de-doctorat).

The macros `\hdr` and `\master` specify that the thesis is respectively for a *habilitation à diriger les recherches* and for a master thesis.

A GitHub Actions pipeline automatically compiles the project with each new commit. This ensures that the LaTeX code compiles correctly with each change, if the job is successful!

Once the job is complete, you can download the compiled PDF directly from your GitHub artifacts:

Go to the **Actions** tab:

![GitHub Actions tab](assets/github_actions_tab.png)

Select the latest workflow, corresponding to your commit:

![GitHub Actions Workflow](assets/build_workflow.png)

Finally, download your compiled PDF file:

![Downloading the compiled artifact](assets/download_artifact.png)

Do not hesitate to post issues or pull requests to improve this model.
